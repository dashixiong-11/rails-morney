class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://baidu.com'
    mail(to: @user.email, subject: '欢迎来到 xxx')
  end
end
