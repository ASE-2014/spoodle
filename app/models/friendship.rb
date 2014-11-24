class Friendship < ActiveRecord::Base

  belongs_to :friend_one, foreign_key: 'friend_one_id', class_name: 'User'
  belongs_to :friend_two, foreign_key: 'friend_two_id', class_name: 'User'

  after_save :add_to_users

  validates :friend_one, presence: true
  validates :friend_two, presence: true

  validate :not_already_friends
  validate :not_forever_alone

  def add_to_users
    p "Added friendship to #{self.friend_one} and #{self.friend_two}"
    self.friend_one.friendships << self
    self.friend_two.friendships << self
    p "Added friendship to #{self.friend_one} and #{self.friend_two}"
  end

  def not_already_friends
    errors.add(:friendship, 'You two are already friends!') if self.friend_one.friends_with self.friend_two
  end

  def not_forever_alone
    errors.add(:friendship, 'You cannot be friends with yourself!') if self.friend_one.eql? self.friend_two
  end

  def includes?(user)
    user.eql? self.friend_one or user.eql? self.friend_two
  end

  def friend_of(user)
    if not (friend_one.eql? user or friend_two.eql? user)
      nil
    else
      friend_one if friend_two.eql? user
      friend_two if friend_one.eql? user
    end
  end


end