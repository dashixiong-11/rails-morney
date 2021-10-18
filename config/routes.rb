Rails.application.routes.draw do
  get '/hello', to: 'first#hello'
  get '/me', to: 'users#me'
  delete '/sessions', to: 'sessions#destroy'


  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # post '/users', to: 'users#create'
  # delete '/users/:id', to: 'users#destroy'
  # patch '/users/:id', to: 'users#update'
  # 等价于下面 resources :users

  resources :users
  resources :sessions, only: [:create]
end
