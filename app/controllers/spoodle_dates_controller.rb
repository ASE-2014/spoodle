class SpoodleDatesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:destroy]
  before_filter :invited_or_owner_of_event!, only: [:assign, :cancel]

  # Creates a new availability between a user and a spoodle_date
  def assign
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    @availability = @spoodle_date.availabilities.new(availability_params);
    @availability.user = current_user
    if @availability.save
      flash[:success] = "You are now assigned at #{@spoodle_date.from}"
    else
      flash[:error] = "You could not be assigned to the date!"
    end
    redirect_to @event
  end

  # Removes an existing availability between a user and a spoodle_date
  def cancel
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    @availability = @spoodle_date.availabilities.find_by(user: current_user)
    if @availability.destroy
      flash[:success] = "You canceled at #{@spoodle_date.from}"
    else
      flash[:error] = "You could not cancel the date!"
    end
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    if @spoodle_date.destroy
      flash[:success] = "Date at #{@spoodle_date.from} deleted"
    else
      flash[:error] = "Date could not be deleted!"
    end
    redirect_to @event
  end

  private

  def availability_params
    params.permit(:weight)
  end

end