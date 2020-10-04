class SessionsController < ApplicationController
  
  include Login

  skip_before_action :authenticate_user!

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      login_success(user)
    else
      login_invalid
    end
  end

  def destroy
    @current_user = nil
    reset_session
    redirect_to root_path
  end
end
