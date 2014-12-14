class FriendshipsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :belongs_to_friendship!, only: [:destroy]

  def create
    session[:return_to] ||= request.referer
    friend = User.find(params[:friend_id])
    @friendship = Friendship.new(friend_one: current_user, friend_two: friend)
    if @friendship.save
      flash[:success] = "#{friend.username} added as new friend"
    else
      flash[:error] = "#{friend.username} could not be added as new friend!"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    @friendship = Friendship.find(params[:id])
    friend = @friendship.friend_of current_user
    if @friendship.destroy
      flash[:success] = "Friend #{friend.username} removed!"
    else
      flash[:error] = "Friend #{friend.username} could not be removed!"
    end
    redirect_to session.delete(:return_to)
  end

  protected

  # Controls if the current user belongs to the friendship
  def belongs_to_friendship!
    @friendship = Friendship.find(params[:id])
    unless @friendship.includes? current_user
      flash[:error] = "Thats not your friendship!"
      redirect_to user_path(current_user)
    end
  end

end