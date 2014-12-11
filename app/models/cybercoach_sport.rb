#CyberCoach to object mapping
class CybercoachSport < CybercoachResource
  # Specifies which data attributes make sense for a sport
  def data_attributes
    case self.name
      when "Running"
        return [:duration, :distance, :document] #TODO add more fields
      when "Soccer"
        return [:duration, :party_1_name, :party_2_name, :winner_name, :score_1, :score_2] #TODO add more fields
      when "Boxing"
        return [:duration, :party_1_name, :party_2_name, :winner_name] #TODO add more fields
      when "Cycling"
        return [:duration, :distance, :document] #TODO add more fields
      else
        return []
    end
  end

end