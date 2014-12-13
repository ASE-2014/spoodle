class EventData < ActiveRecord::Base

  belongs_to :event
  has_one :document

  accepts_nested_attributes_for :document, allow_destroy: true, update_only: true

  validates_numericality_of :distance, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :score_1, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :score_2, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :elevation_gain, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :rounds, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :party_1_red_cards, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :party_2_red_cards, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :party_1_yellow_cards, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :party_2_yellow_cards, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :party_1_penalties, greater_than_or_equal_to: 0, allow_nil: true
  validates_numericality_of :party_2_penalties, greater_than_or_equal_to: 0, allow_nil: true

  # Specifies which attributes are relevant in this case (depends on sport)
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