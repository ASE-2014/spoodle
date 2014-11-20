class FriendshipsController < ApplicationController

  before_filter :authenticate_user!

  def create
    redirect_to users_path if current_user.friends.exists?(params[:friend_id]) or params[:friend_id] == current_user.id #TODO refactor (outsource into model)

    @friendship = current_user.friendships.build(:friend_id => params[:friend_id]) #TODO refactor (use new?)
    @friend = User.find(params[:friend_id])
    @reverse_friendship = @friend.friendships.build(:friend_id => current_user.id) #TODO refactor (use new?)
    if @friendship.save and @reverse_friendship.save
      flash[:success] = "#{@friend.username} added as a friend"
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