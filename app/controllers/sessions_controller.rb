class SessionsController < Devise::SessionsController

# GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

# POST /resource/sign_in
  def create

    rest_user=RestUser.rest_authenticate(resource_params[:login], resource_params[:password])

    if rest_user
      #TODO test if the user is already in the local database, sign in, else create it
    end

    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
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
