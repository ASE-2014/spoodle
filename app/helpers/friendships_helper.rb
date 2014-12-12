module FriendshipsHelper

  def add_friend_button?(user)
    not (current_user.friends_with user or current_user.eql? user)
  end

  def add_unfriend_button?(user)
    current_user.friends_with user
  end

  def friendship_of(user1, user2)
    return nil unless user1.friends_with user2
    user1.friendships.each do |friendship|
      return friendship if friendship.includes? user2
    end
  end

end