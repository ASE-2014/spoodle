class SpoodleDatesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:destroy]
  before_filter :invited_or_owner_of_event!, only: [:assign, :cancel]

  def assign
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    if @spoodle_date.users << current_user
      flash[:success] = "You are now assigned at #{@spoodle_date.datetime}"
    else
      flash[:error] = "You could not be assigned to the date!"
    end
    redirect_to @event
  end

  def cancel
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    if @spoodle_date.users.delete(current_user)
      flash[:success] = "You canceled at #{@spoodle_date.datetime}"
    else
      flash[:error] = "You could not cancel the date!"
    end
    redirect_to @event
  end

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