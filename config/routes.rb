Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'events#index'


  resources :users, only: [:show]
  resources :events do
    resources :attendances
    resources :charges, only: [:new, :create]
  end

  # Pages de l'exo préalable
  get 'static_pages/index'
  get 'static_pages/secret'
end
