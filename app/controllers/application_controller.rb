class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :switch_locale
  # before_action :switch_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name ])
  end

  def switch_locale(&action)
    if params[:locale] == "en" && I18n.locale == :"pt-BR"
      I18n.locale = :en
    elsif params[:locale] == "pt-BR" && I18n.locale == :en
      I18n.locale = :"pt-BR"
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
    I18n.with_locale(I18n.locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
