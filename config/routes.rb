Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root to: "home#index"


  resources :users
  resources :items
  scope :items do
    namespace :api do
      resources :category, only: :index, defaults: { format: 'json' }
    end
  end
  resources :orders

end


