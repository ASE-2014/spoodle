class SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    rest_user = RestUser.rest_authenticate(params[:username], params[:password])

    if rest_user
      # REMOTE Session
      Api::Base.user = session[:username]
      Api::Base.password = params[:password]

      # LOCAL Session
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

  end


  # DELETE /resource/sign_out
  def destroy
    # LOCAL Session
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    # REMOTE Session
    Api::Base.user = nil
    Api::Base.password = nil

    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end

end
