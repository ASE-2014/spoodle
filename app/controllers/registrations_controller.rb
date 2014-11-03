class RegistrationsController < Devise::RegistrationsController

  before_filter :destroy_user_on_cyber_coach, only: :destroy

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

end