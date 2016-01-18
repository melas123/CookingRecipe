class IngredientRecipeController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]
  def create
    params["_json"].each do |attributes|
      IngredientRecipe.create( recipe_id:          attributes["recipe_id"],
                               ingredient_id:      attributes["ingredient_id"],
                               quantity:           attributes["quantity"],
                               mass_unit:          attributes["mass_unit"],
                               volume_unit:        attributes["volume_unit"],
                               measure:            attributes["measure"])
    end  
      
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
