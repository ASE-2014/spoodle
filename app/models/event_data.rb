class EventData < ActiveRecord::Base

  belongs_to :event
  has_one :document

  accepts_nested_attributes_for :document, allow_destroy: true, update_only: true

  validates :distance, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :score_1, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :score_2, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :elevation_gain, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :rounds, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :party_1_red_cards, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :party_2_red_cards, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :party_1_yellow_cards, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :party_2_yellow_cards, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :party_1_penalties, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :party_2_penalties, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true

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