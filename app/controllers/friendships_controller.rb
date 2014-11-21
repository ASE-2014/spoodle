class FriendshipsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :owns_friendship!

  def create
    friend = User.find(params[:friend_id])
    @friendship = Friendship.new(user: current_user, friend: friend)
    if @friendship.save
      flash[:success] = "#{friend.username} added as new friend"
    else
      flash[:error] = "#{friend.username} could not be added as new friend!"
    end
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    friend = @friendship.friend
    if @friendship.destroy
      flash[:success] = "Friend #{friend.username} removed!"
    else
      flash[:error] = "Friend #{friend.username} could not be removed!"
    end
    redirect_to user_path(current_user)
  end

  protected

  def owns_friendship!
    #TODO check if current_user belongs to the friendship, redirect if not
  end

end