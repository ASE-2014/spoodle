class FollowersController < ApplicationController
  def search
      @searched_users = User.search(params[:search])
      render 'followers/new'
  end
end
