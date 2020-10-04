class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  before_action :authenticate_user!

  private

  def authenticate_user!
    return if current_user

    session[:target_url] = request.path
    redirect_to login_path, alert: 'Please authenticate first'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
