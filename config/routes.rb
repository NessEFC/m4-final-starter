Rails.application.routes.draw do
  root to: "links#index"

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'

  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
