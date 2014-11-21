class FriendshipsController < ApplicationController

  before_filter :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    @friendship = Friendship.new(user: current_user, friend: friend)
    if @friendship.save
      flash[:success] = "#{friend.username} added as a friend"
    else
      flash[:error] = "Friend could not be added!"
    end
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @reverse_friendship = @friendship.friend.friendships.find_by_friend_id(@friendship.user_id)
    @friendship.destroy #TODO maybe use dependent: :destroy
    @reverse_friendship.destroy #TODO maybe use dependent: :destroy
    flash[:success] = "Friend removed."
    redirect_to authenticated_root_path
  end

end