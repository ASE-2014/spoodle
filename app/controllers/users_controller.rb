class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  # Lists all users, except the current user
  def index
    @users = User.all_except current_user
    if params[:search]
      @users = search(@users, params[:search])
    end
  end

  def search(users, query)
    query = query.downcase
    users.select{ |user| (user.username.downcase.include? query or user.email.include? query) }
  end

end