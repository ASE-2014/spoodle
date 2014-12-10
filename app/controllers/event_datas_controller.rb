class EventDatasController < ApplicationController
  before_filter :authenticate_user!
  before_filter :owns_event!

  def new
    @event = Event.find(params[:event_id])
    if not @event.event_data.nil?
      flash[:error] = "You have already added event data. Please use edit."
      redirect_to @event
    else
      @event_data = @event.build_event_data
      @document = @event.event_data.build_document
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @event_data = @event.build_event_data(event_data_params)
    if @event_data.save
      flash[:success] = "Successfully saved event data."
      redirect_to @event
    else
      flash[:error] = "Could not save event data."
      redirect_to new_event_event_data_path
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @event_data = EventData.find(params[:id])
    if @event_data.destroy
      flash[:success] = "Successfully deleted event data."
    else
      flash[:error] = "Event data couldn't be deleted!"
    end
    redirect_to @event
  end

  def edit
    @event = Event.find(params[:event_id])
    @event_data = EventData.find(params[:id])
    @document = @event_data.document || @event_data.build_document
  end

  def update
    @event = Event.find(params[:event_id])
    @event_data = EventData.find(params[:id])
    if @event_data.update(event_data_params)
      flash[:success] = "Successfully updated event data."
      redirect_to @event
    else
      flash[:error] = "Could not update event data."
      render :edit
    end
  end

  def event_data_params
    @event = Event.find(params[:event_id])
    attributes = @event.sport.data_attributes
    document_attributes = []
    if attributes.delete(:document) == :document
      document_attributes = [:file]
    end
    params.require(:event_data).permit(attributes, document_attributes: document_attributes)
  end
end
