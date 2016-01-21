class IngredientRecipeController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]
  def create
    IngredientRecipe.create(recipe_id: params[:recipe_id],
                                   ingredient_id: params[:ingredient_id],
                                   quantity: params[:quantity],
                                   unit: params[:unit])
  end

  def index
    @ingredient_recipes = Recipe.find(params[:recipe_id]).ingredient_recipes
  end

  def update
    IngredientRecipe.find(params[:id]).update(quantity: params[:quantity])
  end


  def destroy
    IngredientRecipe.find(params[:id]).destroy
  end

end
