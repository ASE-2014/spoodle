class EventData < ActiveRecord::Base

  belongs_to :event

  has_one :document
  accepts_nested_attributes_for :document, allow_destroy: true, update_only: true

  validates :distance, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :score_1, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true
  validates :score_2, :numericality => {greater_than_or_equal_to: 0}, allow_nil: true

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