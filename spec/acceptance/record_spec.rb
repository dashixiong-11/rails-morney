require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Record" do
  post "/records" do
    parameter :amount, '金额', type: :integer, required: true # 对参数进行说明 方便生成文档
    parameter :category, '类型:1 outgoings|2 income', type: :string, required: true # 对参数进行说明 方便生成文档
    parameter :notes, '备注', type: :string
    example "创建记录" do
      login_in # 由于这里也用到了 登录，所以生成文档的时候也把这个 生成了 在 api_documentation_helper.rb 中可以配置
      do_request(amount: 1000, category: 'outgoings', notes: '备注')
      expect(status).to eq 200
    end
  end
end