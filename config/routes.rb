Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'items#index'
  resource  :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
