class User < ApplicationRecord
  has_secure_password

  has_many :records
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password_confirmation, on: [:create]
  validates_format_of :email, with: /.+@.+/, if: :email, allow_blank: true # 允许为空字符串，如果传入空字符串，则跳过这条验证
  # 另一种写法 if: Proc.new{ |u| u.email.present?}

  validates :password, length: { minimum: 6 }, on: [:create], if: :password

  after_create :send_welcome_email #当user被成功创建后调用

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

end
