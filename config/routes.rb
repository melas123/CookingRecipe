Rails.application.routes.draw do
  #TODO : change this to resources
  post 'ingredient_recipe/new'
  get 'ingredient_recipe/index/:recipe_id' => 'ingredient_recipe#index'
  put 'ingredient_recipe/update'
  delete 'ingredient_recipe/delete'

  post 'ingredient/new'
  get 'ingredient/index'
  put 'ingredient/update'
  delete 'ingredient/delete'
  #end todo
  resources :image
  devise_for :users
  root to: 'application#angular'
end
