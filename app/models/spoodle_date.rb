class SpoodleDate < ActiveRecord::Base

  belongs_to :event
  has_and_belongs_to_many :users

  validates :from, presence: true
  validates :to, presence: true
  validate :from_before_to

  def from_before_to
    errors.add(:spoodle_date, ' must end after it started, not before!') if self.from > self.to
  end

  def is_assigned?(user)
    self.users.include? user
  end

end