class FollowersController < ApplicationController
  def search
      @searched_users = User.search(params[:search]).order("created_at DESC")
      render 'followers/new'
  end
end
