Rails.application.routes.draw do
  resources :image
  resources :ingredient
  resources :ingredient_recipe
  devise_for :users
  root to: 'application#angular'
end
