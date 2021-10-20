class UsersController < ApplicationController
  def create
    # user.email = params[:email]
    # user.password = params[:password]
    # user.password_confirmation = params[:password_confirmation]
    render_resource User.create create_params
  end

  def me
      render_resource current_user
  end
  def create_params # 拿到参数
    params.permit(:email, :password, :password_confirmation)
  end
end
