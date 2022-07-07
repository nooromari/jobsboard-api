# frozen_string_literal: true

Rails.application.routes.draw do
  resources :jobs do
    resources :applications, only: %i[index create show]
  end

  post 'auth/login', to: 'authentication#authenticate'

  post 'signup', to: 'users#create'
end
