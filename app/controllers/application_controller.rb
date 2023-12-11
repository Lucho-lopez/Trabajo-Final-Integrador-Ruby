class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    permit_devise_parameter_keys([:username, :email, :password, :password_confirmation, :remember_me], :sign_up)
    permit_devise_parameter_keys([:login, :password], :sign_in)
    permit_devise_parameter_keys([:username, :email, :password, :password_confirmation, :remember_me], :account_update)
  end

  def permit_devise_parameter_keys(keys, action)
    devise_parameter_sanitizer.permit(action, keys: keys)
  end
end
