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
    if @event.save
      flash[:success] = "Successfully created Event '#{@event.title}'."
      redirect_to events_path
    else
      @users = User.all_except current_user # Since render will not call events#new
      @sports = CybercoachSport.get_all
      
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_update_params)
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
    @upcoming_events = Event.get_upcoming(current_user)
    if params[:search]
      @upcoming_events = search(@upcoming_events, params[:search])
    end
  end

  def passed
    @passed_events = Event.get_passed(current_user)
    if params[:search]
      @passed_events = search(@passed_events, params[:search])
    end
  end

  def pending
    @pending_events = Event.get_pending(current_user)
    if params[:search]
      @pending_events = search(@pending_events, params[:search])
    end
  end

  def index
    @my_events = Event.get_own(current_user)
    if params[:search]
      @my_events = search(@my_events, params[:search])
      (params[:search])
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :deadline, :sport_id, spoodle_dates_attributes: [:id, :from, :to, :_destroy], invitations_attributes: [:id, :user_id, :_destroy])
  end

  # Don't allow invitations_attributes, since the invitations can't be deleted.
  # Invitations are added through the invitations controller.
  def event_update_params
    params.require(:event).permit(:title, :description, spoodle_dates_attributes: [:id, :from, :to, :_destroy])
  end

end