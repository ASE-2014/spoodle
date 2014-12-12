class Invitation < ActiveRecord::Base
  # Allows a user to be invited to a specific event
  belongs_to :user
  belongs_to :event

  validate :owner_can_not_be_invited
  validate :user_can_be_invited_only_once

  def owner_can_not_be_invited
    errors.add(:invitation, 'The owner doesn\'t need to be invited!') if !self.event.nil? and self.user.eql? self.event.owner
  end

  def user_can_be_invited_only_once
    errors.add(:invitation, "#{self.user} is already invited!") if self.event.is_invited? self.user
  end

end