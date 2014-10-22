class SpoodleDatesController < ApplicationController

  def destroy
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    if @spoodle_date.destroy
      flash[:success] = "Date at #{@spoodle_date.datetime} deleted"
    else
      flash[:error] = "Date could not be deleted!"
    end
    redirect_to event_path(@event)
  end

end