module EventHelper

  def all_sports
    CybercoachSport.get_all
  end

end