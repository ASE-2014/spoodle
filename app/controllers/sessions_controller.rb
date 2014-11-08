class SessionsController < Devise::SessionsController

  after_filter :login_on_cyber_coach, only: :create
  before_filter :logout_on_cyber_coach, only: :destroy

  private

  def login_on_cyber_coach
    current_user.login_on_cyber_coach if user_signed_in?
  end

  def logout_on_cyber_coach
    current_user.logout_on_cyber_coach
  end

end