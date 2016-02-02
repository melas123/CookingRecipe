Rails.application.routes.draw do

  get  'profile/index'
  get  'profile/favorite_list'          => "profile#favorite_list"
  get  'profile/isFavorite/:recipe_id'  => "profile#isFavorite"
  get  'profile/find_user/:user_id'     => "profile#find_user"
  get  'profile/recipes_user/:user_id'  => "profile#recipes_user"
  post 'profile/create_favorite'
  post 'profile/destroy_favorite'

  post 'relationship/follow'
  post 'relationship/unfollow'
  get  'relationship/followers/:user_id'        => "relationship#followers"
  get  'relationship/following/:user_id'        => "relationship#following"
  get  'relationship/nbrFollowers/:user_id'     => "relationship#nbrFollowers"
  get  'relationship/nbrFollowing/:user_id'     => "relationship#nbrFollowing"
  get  'relationship/followed_recipes/:user_id' => "relationship#followed_recipes"
  get  'relationship/isFollowed/:followed_id'   => "relationship#isFollowed"

  resources :image, only: [ :index, :create, :destroy, :update ]
  resources :ingredient, only: [ :index, :create ]
  resources :ingredient_recipe
  resources :recipe , only: [:index,:show,:update,:create,:destroy,:create_favorite]
  post 'recipe/create_favorite' => "recipe#create_favorite"
  resources :recipe , only: [:index,:show,:update,:create,:destroy,:create_favorite] do
    resources :comments
  end
  resources :rates
  devise_for :users
  root to: 'application#angular'
end
