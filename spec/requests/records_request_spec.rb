require 'rails_helper'

RSpec.describe "Record", type: :request do
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