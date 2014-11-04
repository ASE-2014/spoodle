class Event < ActiveRecord::Base

  belongs_to :owner, foreign_key: 'owner_id', class_name: 'User'
  belongs_to :definitive_date, foreign_key: 'definitive_date_id', class_name: 'SpoodleDate'
  belongs_to :deadline, foreign_key: 'deadline_id', class_name: 'SpoodleDate'

  has_many :spoodle_dates
  accepts_nested_attributes_for :spoodle_dates, allow_destroy: true

  has_many :invitations
  accepts_nested_attributes_for :invitations, allow_destroy: true

  #TODO :users are not unique! Solution searched! Please help!
  has_many :users, through: :invitations

  validates :title, presence: true

  #TODO Create a validation that the owner of the event can not be invited!
  #TODO Create a validation that the deadline of the event can not be before a spoodle date!
  #TODO Create a validation that the definitive date is after the deadline!

  def owns_event?(user)
    self.owner == user
  end

  def is_invited?(user)
    self.invitations.each do |invitation|
      return true if invitation.user.eql? user
    end
    return false
  end

end