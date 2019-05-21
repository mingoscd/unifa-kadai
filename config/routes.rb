# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'sessions#new'
  resource :sessions, only: %i[new create destroy]
  resources :user, only: [] do
    get '/', to: 'pictures#index'
    get '/upload', to: 'pictures#new'
    post '/upload', to: 'pictures#upload'
  end
  get '/oauth/callback', to: 'oauth#callback'
  post '/oauth/tweet', to: 'oauth#tweet'
end
