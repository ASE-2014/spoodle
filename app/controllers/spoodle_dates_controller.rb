class SpoodleDatesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_event!, only: [:destroy]
  before_filter :invited_or_owner_of_event!, only: [:assign, :cancel]

  # Creates a new availability between a user and a spoodle_date
  def assign
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    @availability = @spoodle_date.availabilities.new(availability_params)
    @availability.user = current_user
    if @availability.save
      flash[:success] = "Successfully assigned weight #{@availability.weight} to #{@spoodle_date.from.strftime("%a, %d.%m.%y: %R")}"
    else
      flash[:error] = "The Date at #{@spoodle_date.from.strftime("%a, %d.%m.%y: %R")} could not be assigned!"
    end
    redirect_to @event
  end

  # Destroys an existing availability between a user and a spoodle_date
  def cancel
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    @availability = @spoodle_date.availabilities.find_by(user: current_user)
    if @availability.destroy
      flash[:success] = "Successfully canceled assignment at #{@spoodle_date.from.strftime("%a, %d.%m.%y: %R")}."
    else
      flash[:error] = "The Date at #{@spoodle_date.from.strftime("%a, %d.%m.%y: %R")} could not be canceled!"
    end
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:event_id])
    @spoodle_date = SpoodleDate.find(params[:id])
    if @spoodle_date.destroy
      flash[:success] = "Successfully deleted Date at #{@spoodle_date.from.strftime("%a, %d.%m.%y: %R")}."
    else
      flash[:error] = "The Date at #{@spoodle_date.from.strftime("%a, %d.%m.%y: %R")} could not be deleted!"
    end
    redirect_to @event
  end

  private

  def availability_params
    params.permit(:weight)
  end

end