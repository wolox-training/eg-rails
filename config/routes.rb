require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :books
      resources :book_suggestions
      resources :rents

      root to: "users#index"
    end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :books, only: [:index, :show] do
        get :search, on: :collection
      end

      resources :rents, only: [:index, :create]
      resources :book_suggestions, only: [:create]
    end
  end
end
