Rails.application.routes.draw do
  resources :image
  resources :ingredient, only: [ :index, :create]
  resources :ingredient_recipe
  resources :recipe , only: [:index,:show,:update,:create,:destroy]
  resources :comments
  devise_for :users
  root to: 'application#angular'
end
