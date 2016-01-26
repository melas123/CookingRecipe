Rails.application.routes.draw do

  get 'profile/index'

  post 'relationship/follow'
  post 'relationship/unfollow'
  get 'relationship/followers/:user_id' => "relationship#followers"
  get 'relationship/following/:user_id' => "relationship#following"

  resources :image, only: [ :index, :create, :destroy, :update ]
  resources :ingredient, only: [ :index, :create ]
  resources :ingredient_recipe
  resources :recipe , only: [ :index,:show,:update,:create,:destroy ]
  resources :comments
  resources :rates
  devise_for :users
  root to: 'application#angular'
end
