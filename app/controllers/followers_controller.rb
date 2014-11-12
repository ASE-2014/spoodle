class FollowersController < ApplicationController
  def index
    if params[:search]
      @searched_users = User.search(params[:search]).order("created_at DESC")
      render 'followers/new'
    end
  end
end
