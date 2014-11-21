class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates :user, presence: true
  validates :friend, presence: true

  validate :not_already_friends
  validate :not_forever_alone

  def not_already_friends
    errors.add(:friendship, 'You two are already friends!') if self.user.friends_with self.friend
  end

  def not_forever_alone
    errors.add(:friendship, 'You cannot be friends with yourself!') if self.user.eql? self.friend
  end

end