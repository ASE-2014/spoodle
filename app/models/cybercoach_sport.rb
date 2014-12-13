#CyberCoach to object mapping
class CybercoachSport < CybercoachResource
  # Specifies which data attributes make sense for a sport
  def data_attributes
    case self.name
      when "Running"
        return [:duration, :distance, :elevation_gain,  :document]
      when "Soccer"
        return [:duration, :party_1_name, :party_2_name, :winner_name, :score_1, :score_2, :party_1_red_cards, :party_2_red_cards, :party_1_yellow_cards, :party_2_yellow_cards]
      when "Boxing"
        return [:duration, :party_1_name, :party_2_name, :winner_name, :rounds]
      when "Cycling"
        return [:duration, :distance, :elevation_gain, :document]
      else
        return []
    end
  end

end