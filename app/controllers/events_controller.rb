class EventsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:update, :edit, :destroy]
  before_filter :invited_or_owner_of_event!, only: [:show]

  def new
    @event = Event.new
    @event.spoodle_dates.build # (DEV) Create one empty date to begin with
    @users = User.all
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_user
    if @event.save
      flash[:success] = "Event '#{@event.title}' was created"
      redirect_to events_path
    else
      @users = User.all # Since render will not call events#new
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
      flash[:success] = "Event deleted"
    else
      flash[:error] = "Event could not be deleted!"
    end
    redirect_to events_path
  end

  def index
    p current_user.username
    @events = Event.select{ |event| (event.is_invited? current_user or event.owner.eql? current_user) }
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, spoodle_dates_attributes: [:id, :datetime, :_destroy], invitations_attributes: [:id, :user_id, :_destroy])
  end

  # Don't allow invitations_attributes, since the invitations can't be deleted.
  # Invitations are added through the invitations controller.
  def event_update_params
    params.require(:event).permit(:title, :description, spoodle_dates_attributes: [:id, :datetime, :_destroy])
  end

end