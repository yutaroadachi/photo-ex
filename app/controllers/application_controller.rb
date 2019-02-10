class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include SessionsHelper

  #リダイレクト先の指定
  def after_sign_up_path_for(resource)
    @user
  end

  def after_sign_in_path_for(resource)
    @user
  end

  #ストロングパラメーターの指定
  protected
    def configure_permitted_parameters
      added_attrs = [ :name, :email, :password, :password_confirmation ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end
end