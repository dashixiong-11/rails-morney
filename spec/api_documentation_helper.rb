require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.configure do |config|
  config.before(:each) do |spec|
    if spec.metadata[:type].equal? :acceptance
      header 'Accept', 'application/json'
      header 'Content-Type', 'application/json'
    end
  end
end

module RspecApiDocumentation::DSL
  # DSL methods available inside the RSpec example.
  module Endpoint
    def login_in(user = nil)
      user ||= User.create!(email: 'spec_test_helper@qq.com', password: '123456', password_confirmation: '123456')
      no_doc do # 这个方法是为了不让此段代码生成文档
        client.post '/sessions', { email: user.email, password: user.password }
      end
      user
    end
  end
end
