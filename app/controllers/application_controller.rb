class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale

  add_flash_types :safe_notice # только для отображения ссылок во flash (при желании можно все поменять под классы Bootstrap)

  def default_url_options
    { lang: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
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
