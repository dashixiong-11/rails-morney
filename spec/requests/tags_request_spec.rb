require 'rails_helper'

RSpec.describe "Tags", type: :request do
  context 'create' do
    it "create a tag" do
      login_in
      post '/tags', params: { name: '旅游' }
      body = JSON.parse response.body
      expect(response.status).to eq 200
      expect(body['resource']['id']).to be
    end
    it "can not create a tag without name" do
      login_in
      post '/tags'
      expect(response.status).to eq 422
      body = JSON.parse response.body
      expect(body['errors']['name'][0]).to eq '标签名不能为空'
    end
    it "can not create a tag without login" do
      post '/records', params: { name: '旅游' }
      expect(response.status).to eq 401
    end
  end
  context 'destroy' do
    it 'cant delete a tag without sign in' do
      tag = create :tag
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end

    it 'can delete a record' do
      login_in
      tag = create :tag
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 200
    end
  end
  context 'get' do
    it 'can not get tag without sign in' do
      get '/tags'
      expect(response.status).to eq 401
    end
    it 'can get record with sign in' do
      login_in
      get '/tags'
      expect(response.status).to eq 200
    end
    it 'get the right data' do
      (1..11).to_a.each { |a| create :tag }
      login_in
      get '/tags'
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 5
      expect(response.status).to eq 200
    end
  end

  context 'show' do
    it 'can not get a tag without sign in' do
      tag = create :tag
      get "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end

    it 'can get a tag with sign in' do
      tag = create :tag
      login_in
      get "/tags/#{tag.id}"
      expect(response.status).to eq 200
    end

    it 'can not get a tag with wrong id' do
      login_in
      get "/tags/9999999"
      expect(response.status).to eq 404
    end
  end

  context 'update' do
    it 'can not update a tag without sign in' do
      tag = create :tag
      patch "/tags/#{tag.id}", params: { name: '游戏' }
      expect(response.status).to eq 401
    end

    it 'can update a tag with sign in' do
      login_in
      tag = create :tag
      patch "/tags/#{tag.id}", params: { name: '游戏' }
      body = JSON.parse response.body
      expect(body['resource']['name']).to eq '游戏'
      expect(response.status).to eq 200
    end
  end
end
