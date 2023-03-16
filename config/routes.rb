Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :sleep_records, only: [:create, :index]
      resources :followings, only: [:create, :destroy]
      get 'friends_sleep_records', to: 'friends_sleep_records#index'
    end
  end
end
