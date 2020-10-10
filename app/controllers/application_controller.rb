class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale

  def default_url_options
    return {} if I18n.locale == I18n.default_locale

    { lang: I18n.locale } # { lang: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  protected

  def after_sign_in_path_for(user)
    flash[:notice] = t('.hello', user: user.first_name)
    if user.admin?
      admin_tests_path
    else
      super
    end
  end

  private

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
