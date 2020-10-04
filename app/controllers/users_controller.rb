class UsersController < ApplicationController

  include Login

  skip_before_action :authenticate_user! #, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_success(save)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :login, :email, :password, :password_confirmation)
  end

end
