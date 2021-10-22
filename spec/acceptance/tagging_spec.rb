require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Taggings" do
  let(:record) { Record.create! amount: 100000, category: 'income', notes: '备注' }
  let(:record_id) { record.id }
  let(:tag) { Tag.create! name: 'test' }
  let(:tag_id) { tag.id }
  let(:tagging) { Tagging.create! tag: tag, record: record }
  let(:id) { tagging.id }
  let(:taggings) { (1..11).to_a.map do |a|
    Tagging.create! record: record, tag: Tag.create!(name: "test#{a}")
  end }
  let(:create_taggings) {
    taggings
    nil
  }
  post "/taggings" do
    parameter :tag_id, '标签ID', type: :number, required: true
    parameter :record_id, '记录ID', type: :number, required: true
    example "创建标记" do
      login_in # 由于这里也用到了 登录，所以生成文档的时候也把这个 生成了 在 api_documentation_helper.rb 中可以配置
      do_request
      expect(status).to eq 200
    end
  end

  delete '/taggings/:id' do
    example '删除标记' do
      login_in
      do_request
      expect(status).to eq 200
    end
  end

  get '/taggings' do
    parameter :page, '页码', type: :integer
    let(:page) { 1 }
    example '获取标记' do
      create_taggings
      login_in
      do_request(page: page)
      expect(status).to eq 200
    end
  end

  get '/taggings/:id' do
    example '获取标记详情' do
      login_in
      do_request
      expect(status).to eq 200
    end
  end

end