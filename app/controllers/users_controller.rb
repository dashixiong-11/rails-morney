class UsersController < ApplicationController
  def create
    # user.email = params[:email]
    # user.password = params[:password]
    # user.password_confirmation = params[:password_confirmation]
    user = User.create create_params
    render_resource User.create create_params
    UserMailer.welcome_email(user).deliver_now
  end

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end
end
