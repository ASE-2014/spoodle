class RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  def new
    #Remote
    @rest_user = RestUser.new
    #Local
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    respond_with self.resource
  end

# POST /resource
  def create
    #Remote
    begin
      @rest_user = RestUser.new({:username => sign_up_params[:username], :email => sign_up_params[:email], :password => sign_up_params[:password], :publicvisible => 2, :realname => sign_up_params[:username]}, true)
      status = @rest_user.save!

    rescue
      status = false
    end

    if status
      #Local
      build_resource(sign_up_params)
      resource_saved = resource.save
      yield resource if block_given?
      if resource_saved
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        @validatable = devise_mapping.validatable?
        if @validatable
          @minimum_password_length = resource_class.password_length.min
        end
        respond_with resource
      end
    else
      redirect_to "/", :alert => "Invalid Form Data"
    end


  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end


  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

end