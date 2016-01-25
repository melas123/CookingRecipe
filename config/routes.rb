Rails.application.routes.draw do
  get 'profile/index'

  post 'relationship/follow'
  post 'relationship/unfollow'
  get 'relationship/followers/:user_id' => "relationship#followers"
  get 'relationship/following/:user_id' => "relationship#following"

  resources :image
  resources :ingredient, only: [ :index, :create]
  resources :ingredient_recipe
  resources :recipe , only: [:index,:show,:update,:create,:destroy]
  resources :comments
  
  post 'ingredient_recipe/new'
  get 'ingredient_recipe/index/:recipe_id' => 'ingredient_recipe#index'
  put 'ingredient_recipe/update'
  delete 'ingredient_recipe/delete'

  post 'ingredient/new'
  get 'ingredient/index'
  put 'ingredient/update'
  delete 'ingredient/delete'
  get 'rates/index/:recipe_id' => 'rates#index'
  resources :rates
  devise_for :users
  root to: 'application#angular'
end
