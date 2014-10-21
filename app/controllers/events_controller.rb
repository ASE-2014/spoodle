class EventsController < ApplicationController

  def new
    @event = Event.new
    @event.spoodle_dates.build # (DEV) Create one empty date to begin with
    @sports = get_sports

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
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
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
      flash[:success] = "Event could not be deleted!"
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
    params.require(:event).permit(:title, :description, :sport_id, spoodle_dates_attributes: [:id, :datetime, :_destroy])
  end

  def get_sports
    response = HTTParty.get("http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/sports/",:headers => {'Accept' => 'application/json'})
    response["sports"].collect {|sport| [ sport['name'], sport['id'] ] }
  end

end