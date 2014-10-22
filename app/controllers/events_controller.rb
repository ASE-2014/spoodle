class EventsController < ApplicationController

  def new
    @event = Event.new
    @event.spoodle_dates.build # (DEV) Create one empty date to begin with
    @users = User.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "#{@event.title} created"
    else
      flash[:error] = "Event could not be created!"
    end
    redirect_to events_path
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
    redirect_to events_url
  end

  def index
    @events = Event.all
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