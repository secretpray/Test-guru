class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(user)
    flash[:notice] = "Привет, #{user.first_name}"
    if user.admin?
      admin_tests_path
    else
      super
    end
  end
end
