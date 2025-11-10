Rails.application.routes.draw do
  root "books#index"
  
  get 'login', to: 'sessions#new', as: 'new_session'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'destroy_session'
  
  resources :books do
    resources :reviews, only: [:create, :destroy]
  end
  
  # Refactorización: usar member routes para seguir convenciones RESTful
  resources :users, only: [] do
    member do
      patch :ban
      patch :unban
    end
  end
end