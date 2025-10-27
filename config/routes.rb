Rails.application.routes.draw do
  root "books#index"
  
  resources :books do
    resources :reviews, only: [:create, :destroy]
  end
  
  # Rutas para banear y desbanear usuarios
  patch 'users/:id/ban', to: 'users#ban', as: :ban_user
  patch 'users/:id/unban', to: 'users#unban', as: :unban_user
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
