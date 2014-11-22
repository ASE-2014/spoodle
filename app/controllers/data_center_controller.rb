class DataCenterController < ApplicationController
  before_filter :authenticate_user!

  def show
    # Mapping that maps each sports_id to the sports.name #TODO: fetch this from Cybercoach
    # We need this because we can only group objects of a class by
    # attribute but not by attribute of a referenced object
    mappings = {1 => "Running", 2 => "Cycling", 3 => "Soccer", 4 => "Boxing"}

    # Prepare chart data here nicely. We want no logic in the view.

    sports = Array.new
    Event.get_passed(current_user).each do |e| #TODO refactor when the fixes are merged
      sports.push e.sport.name
    end
    # Convert array containing the sport.name of each event to a hash
    # Mapping each sport.name to its count
    sports = sports.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
    # Order keys alphabetically (so each sport is represented by same color in chart)
    @user_event_sport_data = Hash[sports.sort_by{|k,v| k}]

    # Retrieve a hash mapping each sport_id to its count
    events = Event.group(:sport_id).count
    # Replace sport_id with sport.name in the hash
    events = Hash[events.map {|k, v| [mappings[k], v] }]
    # Order keys alphabetically (so each sport is represented by same color in chart)
    @total_event_sport_data = Hash[events.sort_by{|k,v| k}]
  end

end