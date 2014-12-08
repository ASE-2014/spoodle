class EventDatasController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    if not @event.event_data.nil?
      flash[:error] = "You have already added Event Data. Please use edit."
      redirect_to @event
    else
      @event_data = @event.build_event_data
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @event_data = @event.build_event_data(event_data_params)
    if @event_data.save
      flash[:success] = "Successfully saved Event Data."
      redirect_to @event
    else
      flash[:error] = "Could not save Event Data."
      redirect_to new_event_event_data_path
    end
  end

  def event_data_params
    @event = Event.find(params[:event_id])
    params.require(:event_data).permit(@event.sport.data_attributes)
  end
end
