class Session
  include ActiveModel::Model
  attr_accessor :email, :password, :user
  # attr_accessor :email
  # 等价于
  # @email 声明属性
  # def email 获取 @email 的值
  # def email= 给@email 赋值
  validates :email, presence: true
  validate :check_email, if: :email
  validates :password, presence: true

  validates_format_of :email, with: /.+@.+/, if: :email
  validates :password, length: { minimum: 6 }, if: :password
  validate :email_password_match, if: Proc.new { |s| s.email.present? and s.password.present? }

  def check_email
    @user ||= User.find_by_email email #已经默认声明过有一个 @user 属性了 所以可以直接用
    if user.nil?
      errors.add :email, :not_fund
    end
  end

  def email_password_match
    @user ||= User.find_by_email email
    if user and not user.authenticate(password)
      errors.add :password, :mismatch
    end
  end
end