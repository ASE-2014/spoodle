class DataCenterController < ApplicationController

  before_filter :authenticate_user!

  def show
    # Mapping that maps each sports_id to the sports.name #TODO: fetch this from Cybercoach
    # We need this because we can only group objects of a class by
    # attribute but not by attribute of a referenced object
    mappings = {1 => "Running", 2 => "Cycling", 3 => "Soccer", 4 => "Boxing"}

    # Prepare chart data here nicely. We want no logic in the view.

    sports = Array.new
    distance_cycling_user = 0
    distance_running_user = 0
    distance_other_user = 0
    current_user.passed_events.each do |e|
      sports.push e.sport.name
      unless e.event_data.distance.nil?
        if e.sport.name == 'Running'
          distance_running_user += e.event_data.distance
        elsif e.sport.name == 'Cycling'
          distance_cycling_user += e.event_data.distance
        else
          distance_other_user += e.event_data.distance
        end

      end
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
    @user_distance_sport = {'Running' => distance_running_user, 'Cycling' => distance_cycling_user, 'Other' => distance_other_user}

  end

end