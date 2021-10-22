require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Tag" do
  let(:tag) { Tag.create! name: '旅游' }
  let(:id) { tag.id }
  let(:name) { '旅游' }
  post "/tags" do
    parameter :name, '标签名', type: :string, required: true
    example "创建标签" do
      login_in # 由于这里也用到了 登录，所以生成文档的时候也把这个 生成了 在 api_documentation_helper.rb 中可以配置
      do_request
      expect(status).to eq 200
    end
  end

  delete '/tags/:id' do
    example '删除标签' do
      login_in
      do_request
      expect(status).to eq 200
    end
  end

  get '/tags' do
    (1..11).to_a.each { |a| Tag.create! name: "test#{a}" }
    parameter :page, '页码', type: :integer
    let(:page) { 1 }
    example '获取标签' do
      login_in
      do_request(page: page)
      expect(status).to eq 200
    end
  end

  get '/tags/:id' do
    example '获取标签详情' do
      login_in
      do_request
      expect(status).to eq 200
    end
  end

  patch '/tags/:id' do
    parameter :name, '标签名', type: :string, required: true
    example '更新标签' do
      login_in
      do_request(name: '游戏')
      expect(status).to eq 200
    end
  end
end