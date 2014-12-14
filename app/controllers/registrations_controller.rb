class RegistrationsController < Devise::RegistrationsController

  # Disable that users can delete their account
  def destroy
    flash[:error] = 'You cannot delete your account! We keep it forever! Hahahaha'
    redirect_to authenticated_root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

end