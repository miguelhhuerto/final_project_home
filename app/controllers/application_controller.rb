class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  
  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource) if is_navigational_format?
    end

    
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number, :email, :image, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :phone_number, :email,:image, :password, :current_password])
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_home_index_path
    else
      home_index_path
    end
  end

  def account_update_params
    params.require(resource_name).permit(:username, :email, :phone_number, :password, :password_confirmation, :current_password, :image)
  end
end
