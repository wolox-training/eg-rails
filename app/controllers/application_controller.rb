class ApplicationController < ActionController::API
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name locale])
  end

  def set_locale
    I18n.locale =
      current_api_v1_user.try(:locale) || I18n.default_locale
  end

  def pundit_user
    current_api_v1_user
  end
end
