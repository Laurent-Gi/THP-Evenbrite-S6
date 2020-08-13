Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'events#index'

  # Pas eu le temps pour user
  resources :users, only: [:show]
  resources :events # tout au final !

  # Pages de l'exo préalable
  get 'static_pages/index'
  get 'static_pages/secret'
end
