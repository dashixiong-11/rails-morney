require 'custom_error'

class ApplicationController < ActionController::API
  rescue_from CustomError::MustSignInError, with: :render_must_sign_in #捕获错误 然后执行方法
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found #捕获错误 然后执行方法

  def current_user
    @current_user ||= User.find_by_id session[:current_user_id] # User.find 如果参数为空会报错 所以用find_by_id
  end

  def render_resource(resource)
    return head 404 if resource.nil?
    if resource.errors.empty?
      render json: { resource: resource }, status: 200
    else
      render json: { errors: resource.errors }, status: 422
    end
  end

  def must_sign_in
    if current_user.nil?
      raise CustomError::MustSignInError #raise 以后错误 后面的代码就不会执行
    end
  end

  def render_must_sign_in
    #head status 401
    # head status :unanthorized
    # 与上面等价
    render status: :unauthorized
  end

  def render_not_found
    render status: :not_found
  end
end
