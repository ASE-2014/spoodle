class CybercoachSport < CybercoachResource

  # Specifies which data attributes make sense for a sport
  def data_attributes
    case self.name
      when "running"
        return [:distance]
      when "soccer"
        return [:party_1_name, :party_2_name, :winner_name, :score_1, :score_2]
      when "boxing"
        return [:party_1_name, :party_2_name, :winner_name]
      else
        return []
    end
  end
end