Rails.application.routes.draw do
  root to: "links#index"

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update, :create]
    end
  end
end
