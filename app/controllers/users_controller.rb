class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end
  def create

  end
  def index
    @users = User.where.not(id: current_user.id)
    if params[:search]
      @users = search(@users, params[:search])
    end
  end

  def search(users_array, query)
    query = query.downcase
    users_array.select{ |user| (user.username.downcase.include? query or user.email.include? query) }
  end


end
