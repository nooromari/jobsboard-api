Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :jobs do
    resources :applications
  end

  # resources :users do
  #   resources :applications
  # end

  post 'auth/login', to: 'authentication#authenticate'

  post 'signup', to: 'users#create'
end
