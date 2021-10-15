class UsersController < ApplicationController
  def create
    # user.email = params[:email]
    # user.password = params[:password]
    # user.password_confirmation = params[:password_confirmation]
    render_resource User.create create_params
  end

  def me
    user_id = session[:current_user_id]
    user = User.find user_id
    render_resource user
  end
  def create_params
    params.permit(:email, :password, :password_confirmation)
  end
end
