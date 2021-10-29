require 'rails_helper'

RSpec.describe User, type: :model do
  it '创建用户时需要输入密码' do
    user = create("user")
    expect(user.password_digest).to_not eq '123123'
    expect(user.id).to be_a Numeric
  end
  it '删除 user' do
    user = create("user")
    # expect(User.count).to eq 1
    # User.destroy_by id: user.id
    # expect(User.count).to eq 0
    # expect {  # 期待 括号中的代码 把User.count 从1变成0
    #   User.destroy_by id: user.id
    # }.to change { User.count }.from(1).to(0)
    expect { # 期待 括号中的代码 把User.count 减少一个
      User.destroy_by id: user.id
    }.to change { User.count }.by(-1)
  end

  it '创建user时 是否会验证邮箱' do
    user = build :user, email: ''
    user.validate
    expect(user.errors.details[:email][0][:error]).to eq(:blank)
    # errors.details 能获取model返回的错误原文
  end

  it '创建user时 检测邮箱是否被占用' do
    create(:user, email: '1@qq.com')
    user = build :user, email: '1@qq.com'
    user.validate
    expect(user.errors.details[:email][0][:error]).to eq(:taken)
  end

  it '创建成功 会发邮件' do
    x = spy('xxx')
    allow(UserMailer).to receive(:welcome_email).and_return(x) #运行 UserMailer 的 welcome_email 方法被调用
    # 语序 UserMailer 调用welcome_email之后还需要调用一个方法，所以需要有一个返回值，这个返回值需要通过 spy 构造，才能接受任何调用
    create :user
    expect(UserMailer).to have_received(:welcome_email) # 期待此方法被调用了
    expect(x).to have_received(:deliver_later)
  end

  it '传入的邮箱为空字符串时 提示邮箱不能为空' do
    user = build :user, email: ''
    user.validate
    expect(user.errors.details[:email].length).to eq 1
  end
end
