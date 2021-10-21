require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Record" do
  let(:record) { Record.create! amount: 100000, category: 'income', notes: '备注' }
  let(:id) { record.id }
  let(:amount) { 10000 }
  let(:category) { 'income' }
  let(:notes) { '备注' }
  post "/records" do
    parameter :amount, '金额', type: :integer, required: true # 对参数进行说明 方便生成文档
    parameter :category, '类型:1 outgoings|2 income', type: :string, required: true # 对参数进行说明 方便生成文档
    parameter :notes, '备注', type: :string
    example "创建记录" do
      login_in # 由于这里也用到了 登录，所以生成文档的时候也把这个 生成了 在 api_documentation_helper.rb 中可以配置
      do_request
      expect(status).to eq 200
    end
  end

  delete '/records/:id' do
    example '删除记录' do
      login_in
      do_request
      expect(status).to eq 200
    end
  end

  get '/records' do
    (1..11).to_a.each { |a| Record.create! amount: 10000, category: 'income', notes: '备注' }
    parameter :page, '页码', type: :integer
    let(:page) { 1 }
    example '获取记录' do
      login_in
      do_request(page: page)
      expect(status).to eq 200
    end
  end

  get '/records/:id' do
    example '获取记录详情' do
      login_in
      do_request
      expect(status).to eq 200
    end
  end

  patch '/records/:id' do
    parameter :amount, '金额', type: :integer, required: true # 对参数进行说明 方便生成文档
    parameter :category, '类型:1 outgoings|2 income', type: :string, required: true # 对参数进行说明 方便生成文档
    parameter :notes, '备注', type: :string
    example '更新记录' do
      login_in
      do_request(amount: 20000, category: 'income', notes: '更新')
      expect(status).to eq 200
    end
  end
end