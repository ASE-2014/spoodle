class SpoodleDatesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:destroy]

  def destroy
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    if @spoodle_date.destroy
      flash[:success] = "Date at #{@spoodle_date.datetime} deleted"
    else
      flash[:error] = "Date could not be deleted!"
    end
    redirect_to @event
  end

end