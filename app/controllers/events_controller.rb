class EventsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:update, :edit, :destroy]
  before_filter :invited_or_owner_of_event!, only: [:show]

  def new
    @event = Event.new
    @sports = get_sports.collect {|sport| [ sport['name'], sport['id'] ] }
    @users = User.all_except current_user
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_user
    if @event.save
      flash[:success] = "Successfully created Event '#{@event.title}'."
      redirect_to events_path
    else
      @users = User.all_except current_user # Since render will not call events#new
      @sport_id =  params[:event][:sport_id]
      @sports = get_sports.collect {|sport| [ sport['name'], sport['id'] ] }
      @users = User.all_except current_user
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_update_params)
      redirect_to @event
    else
      @sport = get_sports_by_id[@event.sport_id]['name']
      render :edit
    end
  end

  def edit
    @event = Event.find(params[:id])
    @sport = get_sports_by_id[@event.sport_id]['name']
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
    @upcoming_events = Event.get_upcoming(current_user)
    if params[:search]
      @upcoming_events = search(@upcoming_events, params[:search])
    end
    @sports = get_sports_by_id
  end

  def passed
    @passed_events = Event.get_passed(current_user)
    if params[:search]
      @passed_events = search(@passed_events, params[:search])
    end
    @sports = get_sports_by_id
  end

  def pending
    @pending_events = Event.get_pending(current_user)
    if params[:search]
      @pending_events = search(@pending_events, params[:search])
    end
    @sports = get_sports_by_id
  end

  def index
    @my_events = Event.get_own(current_user)
    if params[:search]
      @my_events = search(@my_events, params[:search])
      (params[:search])
    end
    @sports = get_sports_by_id
  end

  def show
    @event = Event.find(params[:id])
    @sport = get_sports_by_id[@event.sport_id]['name']
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :deadline, :location, :sport_id, spoodle_dates_attributes: [:id, :from, :to, :_destroy], invitations_attributes: [:id, :user_id, :_destroy])
  end

  # Don't allow invitations_attributes, since the invitations can't be deleted.
  # Invitations are added through the invitations controller.
  def event_update_params
    params.require(:event).permit(:title, :description, :location, spoodle_dates_attributes: [:id, :from, :to, :_destroy])
  end

  #AS: TODO: Factor out
  def get_sports_by_id
    by_id = {}
    get_sports.each{ |sport| by_id[sport['id']] = sport.tap{ |sport| sport.delete('id') } }
    by_id
  end

  def get_sports
    response = HTTParty.get("http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/sports/",:headers => {'Accept' => 'application/json'})
    response["sports"]
  end

  # Performs a search query on each event of an array, returns an array of all events matching the query (ignore case)
  # Searches in title, description, sport, owner (username)
  #OS: TODO: Search is slow because it fetches list of sports from cybercoach. Update this method once the sports retrieval has been refactored
  def search(event_array, query)
    query = query.downcase
    sports_by_id = get_sports_by_id
    event_array.select{ |event| (event.title.downcase.include? query or event.description.downcase.include? query or
        sports_by_id[event.sport_id]['name'].downcase.include? query or event.owner.username.downcase.include? query) }
  end

end