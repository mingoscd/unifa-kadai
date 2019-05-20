# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'sessions#new'
  resource :sessions, only: %i[new create destroy]
  resources :user, only: [] do
    get '/', to: 'pictures#index'
  end
end
