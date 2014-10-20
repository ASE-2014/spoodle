class EventsController < ApplicationController

  def new
    @event = Event.new
    @event.spoodle_dates.build # Create one empty date to begin with
    @event.spoodle_dates.build
    @event.spoodle_dates.build
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "#{@event.title} created"
    else
      flash[:success] = "Event could not be created!"
    end
    redirect_to events_path
  end

  def update
  end

  def edit
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "Event deleted"
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
    params.require(:event).permit(:title, :description, spoodle_dates_attributes: [:id, :datetime, :_destroy])
  end

end