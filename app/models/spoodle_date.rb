class SpoodleDate < ActiveRecord::Base

  belongs_to :event
  has_many :availabilities
  has_many :users, through: :availabilities

  validates :from, presence: true
  validates :to, presence: true
  validate :from_before_to

  def from_before_to
    errors.add(:spoodle_date, ' must end after it started, not before!') if self.from > self.to
  end

  def is_assigned?(user)
    self.users.include? user
  end

  # Sums up all availability, each one counts as 1 but is weighted by its creator
  def votes
    votes = 0
    self.availabilities.each do |availability|
      votes += 1 * availability.weight
    end
    votes
  end

  # returns the availability of a given user. Nil if user has no availability.
  def availability(user)
    self.availabilities.each do |a|
      if a.user==user
        return a
      end
    end
    nil
  end

end