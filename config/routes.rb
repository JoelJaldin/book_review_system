Rails.application.routes.draw do
  root "books#index"
  
  # Authentication
  get 'login', to: 'sessions#new', as: 'new_session'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'destroy_session'
  
  resources :books do
    resources :reviews, only: [:create, :destroy]
  end
  
  # Routes for ban/unban users (admin only)
  patch 'users/:id/ban', to: 'users#ban', as: :ban_user
  patch 'users/:id/unban', to: 'users#unban', as: :unban_user
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
