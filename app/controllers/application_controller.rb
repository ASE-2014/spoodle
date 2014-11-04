class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def owns_event!
    event = Event.find(params[:event_id].nil? ? params[:id] : params[:event_id])
    unless event.owns_event? current_user
      flash[:error] = 'You are not the owner of the event!'
      redirect_to events_path
    end
  end

  def invited_or_owner_of_event!
    event = Event.find(params[:event_id].nil? ? params[:id] : params[:event_id])
    unless event.owns_event? current_user or event.is_invited?(current_user)
      flash[:error] = 'You are not invited!'
      redirect_to events_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

end
