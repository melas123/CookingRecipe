Rails.application.routes.draw do

  get 'profile/index'
  get 'profile/favorite_list' => "profile#favorite_list"
  post 'profile/destroy_favorite'

  post 'relationship/follow'
  post 'relationship/unfollow'
  get 'relationship/followers/:user_id' => "relationship#followers"
  get 'relationship/following/:user_id' => "relationship#following"

  resources :image, only: [ :index, :create, :destroy, :update ]
  resources :ingredient, only: [ :index, :create ]
  resources :ingredient_recipe
  resources :recipe , only: [ :index,:show,:update,:create,:destroy ]
  resources :recipe , only: [:index,:show,:update,:create,:destroy,:create_favorite]
  post 'recipe/create_favorite' => "recipe#create_favorite"
  create delete and list  favorite for a user
  resources :comments
  resources :rates
  devise_for :users
  root to: 'application#angular'
end
