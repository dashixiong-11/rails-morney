require 'rails_helper'

RSpec.describe "Taggings", type: :request do
  context 'create' do
    it "create a tagging" do
      login_in
      record = Record.create! amount: 10000, category: 'outgoings', notes: '请客'
      tag = Tag.create! name: 'test'
      post '/taggings', params: { tag_id: tag.id, record_id: record.id }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['id']).to be
    end
    it "can not create a tagging without login" do
      post '/taggings'
      expect(response.status).to eq 401
    end
    it "create a tagging without record_id" do
      login_in
      tag = Tag.create! name: 'test'
      post '/taggings', params: { tag_id: tag.id }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      p body
      expect(body['errors']['record'][0]).to eq '记录不能为空'
    end
    it "create a tagging without tag_id" do
      login_in
      record = Record.create! amount: 10000, category: 'outgoings', notes: '请客'
      post '/taggings', params: { record_id: record.id }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      expect(body['errors']['tag'][0]).to eq '标签不能为空'
    end
  end
end
