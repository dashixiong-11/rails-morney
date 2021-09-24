class UsersController < ApplicationController
  def create
    user = User.new({ email: params[:email], password: params[:password], password_confirm: params[:password_confirm] })
    # user.email = params[:email]
    # user.password = params[:password]
    # user.password_confirmation = params[:password_confirmation]
    user.save
    if user.save
      render json: { resource: user }, status: 200
    else
      render json: { errors: user.errors }, status: 400
    end
    p user.errors
  end
end
