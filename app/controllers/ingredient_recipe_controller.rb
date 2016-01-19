class IngredientRecipeController < ApplicationController
  def new
    ir = IngredientRecipe.create(recipe_id: params[:recipe_id],
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


  def delete
    IngredientRecipe.find(params[:id]).destroy
  end

end
