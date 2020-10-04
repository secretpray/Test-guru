module Login

  extend ActiveSupport::Concern

  private

  def login_success(user)
    session[:user_id] = user.id
    target_url = session[:target_url]
    session[:target_url] = nil

    flash[:info] = "Welcome #{user.login}, Guru!"
    redirect_to target_url || root_path
  end

  def login_invalid
    flash[:alert] = 'Invalid email or password.'
    render :new
  end
end
