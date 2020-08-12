Rails.application.routes.draw do

  root 'events#index'

  # Pages de l'exo préalable
  get 'static_pages/index'
  get 'static_pages/secret'

  # Pas eu le temps pour user
  resources :users, only: [:show]
  resources :events, only: [:index, :show, :new, :create]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
