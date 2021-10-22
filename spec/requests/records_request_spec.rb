require 'rails_helper'

RSpec.describe "Record", type: :request do
  context 'create' do
    it "create a record" do
      login_in
      post '/records', params: { amount: 10000, category: 'outgoings', notes: '请客' }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['id']).to be
    end
    it "can not create a record without amount" do
      login_in
      post '/records', params: { category: 'outgoings', notes: '请客' }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      expect(body['errors']['amount'][0]).to eq '金额不能为空'
    end
    it "can not create a record without login" do
      post '/records', params: { amount: 10000, category: 'outgoings', notes: '请客' }
      expect(response.status).to eq 401
    end
  end
  context 'destroy' do
    it 'cant delete a record without sign in' do
      record = Record.create! amount: 10000, category: 'income', notes: '备注'
      delete "/records/#{record.id}"
      expect(response.status).to eq 401
    end

    it 'can delete a record' do
      login_in
      record = Record.create! amount: 10000, category: 'income', notes: '备注'
      delete "/records/#{record.id}"
      expect(response.status).to eq 200
    end
  end
  context 'get' do
    it 'can not get record without sign in' do
      get '/records'
      expect(response.status).to eq 401
    end
    it 'can  get record with sign in' do
      login_in
      get '/records'
      expect(response.status).to eq 200
    end
    it 'get the right data of record' do
      (1..11).to_a.each { |a| Record.create! amount: 10000, category: 'income', notes: "备注#{a}123" }
      login_in
      get '/records'
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 5
      expect(response.status).to eq 200
    end
  end

  context 'show' do
    it 'can not get a record without sign in' do
      record = Record.create! amount: 10000, category: 'income', notes: '备注'
      get "/records/#{record.id}"
      expect(response.status).to eq 401
    end

    it 'can get a record with sign in' do
      record = Record.create! amount: 10000, category: 'income', notes: '备注'
      login_in
      get "/records/#{record.id}"
      expect(response.status).to eq 200
    end

    it 'can not get a record with wrong id' do
      login_in
      get "/records/9999999"
      expect(response.status).to eq 404
    end
  end

  context 'update' do
    it 'can not update a record without sign in' do
      record = Record.create! amount: 10000, category: 'income', notes: '备注'
      patch "/records/#{record.id}", params: { amount: 20000, category: 'outgoings', notes: '更新了' }
      expect(response.status).to eq 401
    end

    it 'can update a record with sign in' do
      login_in
      record = Record.create! amount: 10000, category: 'income', notes: '备注'
      patch "/records/#{record.id}", params: { amount: 20000, category: 'outgoings', notes: '更新了' }
      body = JSON.parse response.body
      expect(body['resource']['amount']).to eq 20000
      expect(response.status).to eq 200
    end
  end
end