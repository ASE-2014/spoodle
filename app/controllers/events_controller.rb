class EventsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:update, :edit, :destroy]
  before_filter :invited_or_owner_of_event!, only: [:show]

  def new
    @event = Event.new
    @event.spoodle_dates.build # (DEV) Create one empty date to begin with
    @sports = CybercoachSport.get_all
    @users = User.all_except current_user
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_user
    @event.create_event_data
    if @event.save
      flash[:success] = "Successfully created Event '#{@event.title}'."
      redirect_to events_path
    else
      # Recreate all variables, since render will not call events#new
      @users = User.all_except current_user
      @sports = CybercoachSport.get_all
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_update_params)
      flash[:success] = "Successfully updated Event '#{@event.title}'."
      redirect_to @event
    else
      render :edit
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "Successfully deleted Event."
    else
      flash[:error] = "Event could not be deleted!"
    end
    redirect_to events_path
  end

  def upcoming
    @upcoming_events = current_user.upcoming_events
    if params[:search]
      @upcoming_events = search(@upcoming_events, params[:search])
    end
  end

  def passed
    @passed_events = current_user.passed_events
    if params[:search]
      @passed_events = search(@passed_events, params[:search])
    end
  end

  def pending
    @pending_events = current_user.pending_events
    if params[:search]
      @pending_events = search(@pending_events, params[:search])
    end
  end

  def index
    @my_events = current_user.created_events
    if params[:search]
      @my_events = search(@my_events, params[:search])
      (params[:search])
    end
  end

  def show
    @event = Event.find(params[:id])
    #TODO: do this only once
    if @event.is_deadline_over?
      @event.participants.each do |participant|
        participant.create_entry_on_cyber_coach(@event.sport.name.downcase,
                                                          {publicvisible: '2',
                                                           entrylocation: @event.location,
                                                           comment: "I'm taking part to an event!"})
      end

    end
    # Offer the possibility to export event
    # in ical format for pending and passed events
    if @event.is_deadline_over?
      respond_to do |wants|
        wants.html
        wants.ics do
          calendar = Icalendar::Calendar.new
          calendar.add_event(@event.to_ical(request.env["HTTP_HOST"] + event_path(@event)))
          calendar.publish
          response.headers['Content-Disposition'] = 'attachment; filename="spoodle_event_' + @event.id.to_s + '.ics"'
          render :text => calendar.to_ical
        end
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :deadline, :location, :sport_id, spoodle_dates_attributes: [:id, :from, :to, :_destroy], invitations_attributes: [:id, :user_id, :_destroy])
  end

  # Don't allow invitations_attributes, since the invitations can't be deleted.
  # Invitations are added through the invitations controller.
  def event_update_params
    params.require(:event).permit(:title, :description, :location, spoodle_dates_attributes: [:id, :from, :to, :_destroy], event_data_attributes: @event.event_data.attributes)
  end

  # Performs a search query on each event of an array, returns an array of all events matching the query (ignore case)
  # Searches in title, description, sport, owner (username)
  def search(event_array, query)
      query = query.downcase
      event_array.select{ |event| (event.title.downcase.include? query or event.description.downcase.include? query or
              event.sport.name.downcase.include? query or event.owner.username.downcase.include? query) }
  end

end