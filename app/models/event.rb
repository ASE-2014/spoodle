class Event < ActiveRecord::Base

  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  belongs_to :definitive_date, foreign_key: 'definitive_date_id', class_name: 'SpoodleDate'

  has_many :spoodle_dates
  accepts_nested_attributes_for :spoodle_dates, allow_destroy: true

  has_many :invitations
  accepts_nested_attributes_for :invitations, allow_destroy: true

  #TODO :users are not unique! Solution searched! Please help!
  has_many :users, through: :invitations

  validates :title, presence: true
  validates :deadline, presence: true
  validate :minimal_one_spoodle_date
  validate :spoodle_dates_after_deadline

  def minimal_one_spoodle_date
    errors.add(:spoodle_dates, "At least one date must be set!") if spoodle_dates.size <= 0
  end

  def spoodle_dates_after_deadline
    errors.add(:spoodle_dates, "must take place after the deadline!") if spoodle_dates.any?{ |spoodle_date| spoodle_date.datetime < self.deadline }
  end

  def owns_event?(user)
    self.owner == user
  end

  def is_invited?(user)
    self.invitations.each do |invitation|
      return true if invitation.user.eql? user
    end
    return false
  end

  def belongs_to?(user)
    user.eql? self.owner
  end

  def is_upcoming?
    deadline < DateTime.now
  end

end