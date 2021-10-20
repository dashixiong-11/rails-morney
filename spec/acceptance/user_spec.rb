require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
  post "/users" do
    parameter :email, '邮箱', type: :string, required: true # 对参数进行说明 方便生成文档
    parameter :password, '密码', type: :string, required: true
    parameter :password_confirmation, '确认密码', type: :string, required: true
    example "创建用户（注册）" do
      do_request(email: '1@qq.com', password: '123123', password_confirmation: '123123')
      expect(status).to eq 200
    end
  end
end