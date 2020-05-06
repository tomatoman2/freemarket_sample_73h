Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'items#index'
  resources :items do
    
  end
  resources :users
  scope :items do
    namespace :api do
      resources :category, only: :index, defaults: { format: 'json' }
    end
  end
  

end
