class EventData < ActiveRecord::Base

  belongs_to :event

  # Specifies which attributes are actually filled in this case (depends on sport)
  def attributes
    self.event.sport.data_attributes
  end

  def valid_attributes
    attr = {}
    attributes.each do |attribute|
      attr[attribute] = self.send(attribute)
    end
    attr
  end

end