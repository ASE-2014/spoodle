class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    if(current_user.friends.exists?(params[:friend_id]) || params[:friend_id] == current_user.id)
      redirect_to users_path
    else
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      @friend = User.find(params[:friend_id])
      @reverse_friendship = @friend.friendships.build(:friend_id => current_user.id)
      if (@friendship.save && @reverse_friendship.save)
        flash[:success] = "#{@friend.username} added as friend"

        redirect_to users_path
      else
        flash[:success] = "unable to add friend"
        redirect_to users_path
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @reverse_friendship = @friendship.friend.friendships.find_by_friend_id(current_user.id)
    @friendship.destroy
    @reverse_friendship.destroy
    flash[:notice] = "Friend removed."
    redirect_to user_path(current_user)
  end
end
