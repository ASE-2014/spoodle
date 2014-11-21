class DataCenterController < ApplicationController

  def show
    sports = Array.new
    Event.get_passed(current_user).each do |e|
      sports.push e.sport.name
    end
    @data = sports.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
  end

end