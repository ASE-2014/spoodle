module FriendshipsHelper

  def add_friend_button?(user)
    not (current_user.friends_with user or current_user.eql? user)
  end

end