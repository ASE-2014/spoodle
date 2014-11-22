class DataCenterController < ApplicationController
  before_filter :authenticate_user!

  def show
    # Prepare chart data here nicely. We want no logic in the view.
    sports = Array.new
    if Event.get_passed(current_user) #to avoid error if no passed events exist
      Event.get_passed(current_user).each do |e| #TODO refactor when the fixes are merged
        sports.push e.sport.name
      end
    end
    @event_sport_data = sports.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
  end

end