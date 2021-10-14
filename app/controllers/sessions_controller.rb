class SessionsController < ApplicationController
  def create
    s = Session.new create_params #直接new 不会触发校验
    s.validate
    render_resource s #  new一个session 如果通过验证就返回session对象，如果失败就返回错误， 跟user的create 对应 只不过不存入数据库

  end

  def destroy

  end

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end
end
