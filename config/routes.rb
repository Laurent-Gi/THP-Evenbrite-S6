Rails.application.routes.draw do

  root 'events#index'
  get 'static_pages/index'
  get 'static_pages/secret'

  resources :events, only: [:index, :show, :new, :create]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
