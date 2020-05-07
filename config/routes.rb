Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  root 'home#index'

  resources :users
  resources :items
  resources :orders, only: [:new, :create]
  scope :items do
    namespace :api do
      resources :category, only: :index, defaults: { format: 'json' }
    end
  end
end


