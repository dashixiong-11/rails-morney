require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "create user" do
    post '/users', params: { email: '' }
    expect(response.status).to eq 422
    body = JSON.parse response.body
    expect(body['errors']['email'][0]).to eq '邮箱不能为空'
    expect(body['errors']['email'].length).to eq 1
    expect(body['errors']['password'][0]).to eq '密码不能为空'
    expect(body['errors']['password'].length).to eq 1
    expect(body['errors']['password_confirmation'][0]).to eq '请确认密码'
    expect(body['errors']['password_confirmation'].length).to eq 1
  end
  it 'can not get current user without login' do
    get '/me'
    expect(response).to have_http_status :not_found
  end

  it 'get current user with login' do
    user = login_in
    get '/me'
    body = JSON.parse response.body
    expect(response).to have_http_status :ok
    expect(body['resource']['id']).to eq user.id
  end
end
