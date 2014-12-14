class DataCenterController < ApplicationController

  before_filter :authenticate_user!

  def show
    # Mapping that maps each sports_id to the sports.name
    # We need this because we can only group objects of a class by
    # attribute but not by attribute of a referenced object
    mappings = {1 => "Running", 2 => "Cycling", 3 => "Soccer", 4 => "Boxing"}

    # Prepare chart data here nicely. We want no logic in the view.

    sports = Array.new
    @user_distance_sport = {'Cycling' => 0, 'Running' => 0, 'Other' => 0}
    @user_elevation_gain_sport = {'Cycling' => 0, 'Running' => 0, 'Other' => 0}
    current_user.passed_events.each do |e|
      sports.push e.sport.name

      unless e.event_data.distance.nil?
        if e.sport.name == 'Running'
          @user_distance_sport['Running'] += e.event_data.distance
        elsif e.sport.name == 'Cycling'
          @user_distance_sport['Cycling'] += e.event_data.distance
        else
          @user_distance_sport['Other'] += e.event_data.distance
        end
      end

      unless e.event_data.elevation_gain.nil?
        if e.sport.name == 'Running'
          @user_elevation_gain_sport['Running'] += e.event_data.elevation_gain
        elsif e.sport.name == 'Cycling'
          @user_elevation_gain_sport['Cycling'] += e.event_data.elevation_gain
        else
          @user_elevation_gain_sport['Other'] += e.event_data.elevation_gain
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

    # Total distances by means of transport
    @total_distance_sport = {'Cycling' => 0, 'Running' => 0}
    @total_distance_sport['Running'] = Event.includes(:event_data).where(:sports_name => 'Running').sum(:distance)
    @total_distance_sport['Cycling'] = Event.includes(:event_data).where(:sports_name => 'Cycling').sum(:distance)

    # Total distances by means of transport
    @total_elevation_gain_sport = {'Cycling' => 0, 'Running' => 0}
    @total_elevation_gain_sport['Running'] = Event.includes(:event_data).where(:sports_name => 'Running').sum(:elevation_gain)
    @total_elevation_gain_sport['Cycling'] = Event.includes(:event_data).where(:sports_name => 'Cycling').sum(:elevation_gain)



  end

end