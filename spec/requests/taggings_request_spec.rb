require 'rails_helper'

RSpec.describe "Taggings", type: :request do
  before :each do
    @user = User.create! email: '21s21dsa@qq.com', password: '123456', password_confirmation: '123456'
    @record = create :record, user: @user
    @tag = create :tag
    @tagging = create :tagging, tag: @tag, record: @record
    (1..11).to_a.each { |a| create :tagging }
  end
  context 'create' do
    it "create a tagging" do
      login_in
      post '/taggings', params: { tag_id: @tag.id, record_id: @record.id }
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
      post '/taggings', params: { tag_id: @tag.id }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      p body
      expect(body['errors']['record'][0]).to eq '记录不能为空'
    end
    it "create a tagging without tag_id" do
      login_in
      post '/taggings', params: { record_id: @record.id }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      expect(body['errors']['tag'][0]).to eq '标签不能为空'
    end
  end

  context 'destroy' do
    it 'cant delete a tagging without sign in' do
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end

    it 'can delete a tagging' do
      login_in
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end
  end
  context 'get' do
    it 'can not get taggings without sign in' do
      get '/taggings'
      expect(response.status).to eq 401
    end
    it 'can  get record with sign in' do
      login_in
      get '/taggings'
      expect(response.status).to eq 200
    end
    it 'get the right data' do
      login_in
      get '/taggings'
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 5
      expect(response.status).to eq 200
    end
  end

  context 'show' do
    it 'can not get a tagging without sign in' do
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end

    it 'can get a tagging with sign in' do
      login_in
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end

    it 'can not get a record with wrong id' do
      login_in
      get "/taggings/9999999"
      expect(response.status).to eq 404
    end
  end
end
