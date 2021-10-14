class Session
  include ActiveModel::Model
  attr_accessor :email, :password
  validates :email, presence: true
  validates :password, presence: true
  validates_format_of :email, with: /.+@.+/, if: :email
  validates :password, length: { minimum: 6 }, if: :password

  validate :check_email, if: :email

  def check_email
    user = User.find_by email: email
    if user.nil?
      errors.add :email, :not_fund
    end

  end
end