class CybercoachSport < CybercoachResource

  # Specifies which data attributes make sense for a sport
  def data_attributes
    case self.name
      when "Running"
        return [:distance]
      when "Soccer"
        return [:party_1_name, :party_2_name, :winner_name, :score_1, :score_2]
      when "Boxing"
        return [:party_1_name, :party_2_name, :winner_name]
      else
        return []
    end
  end
end