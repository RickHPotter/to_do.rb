# frozen_string_literal: true

# God Controller
class ApplicationController < ActionController::Base
  # @callbacks ...............................................................
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_locale

  # @protected_instance_methods ..............................................

  protected

  # Configure permitted parameters for Devise controllers.
  #
  # This method is called before processing requests for Devise controllers
  # and configures permitted parameters for sign-up and account update actions.
  #
  # @return [void]
  #
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name image_urll])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name image_url])
  end

  # Set locale from params[:locale] or cookies[:locale]
  #
  # @return [void]
  #
  def set_locale
    local_param = params[:locale]
    local_cookie = cookies[:locale]

    local_cookie = local_param if local_param
    I18n.locale = local_cookie if local_cookie
  end
end
