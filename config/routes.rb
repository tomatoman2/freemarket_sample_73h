Rails.application.routes.draw do
  get 'credit_card/new'
  get 'credit_card/show'
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
  resources :orders, only: [:new, :create] 
    get 'index', to: 'orders#index'

  resources :likes, only: [:index]
  resources :items do
    resources :likes, only: [:create, :destroy]
  end

  scope :items do
    namespace :api do
      resources :category, only: :index, defaults: { format: 'json' }
    end
  end

  resources :credit_card, only: [:new, :show,] do
    collection do
      post 'show', to: 'credit_card#show'
      post 'pay', to: 'credit_card#pay'
      post 'delete', to: 'credit_card#delete'
    end
  end

end
