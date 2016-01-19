class IngredientRecipeController < ApplicationController
  def new
  	if params[:recipe_id] and params[:ingredient_id] and params[:quantity] and params[:unit]
  		ir = IngredientRecipe.create(recipe_id: params[:recipe_id],
                                   ingredient_id: params[:ingredient_id],
  			                           quantity: params[:quantity],
                                   unit: params[:unit])
  		if ir.valid?
  			
  		else
  			 render :status => 500
  		end
  	else
  		render :status => 500
  	end
  end

  def index
    if params[:recipe_id] 
  	  @ingredient_recipes = Recipe.find(params[:recipe_id]).ingredient_recipes
    else
      render :status => 500
    end  
  end

  def update
    if IngredientRecipe.exists?(params[:id])
      IngredientRecipe.find(params[:id]).update(quantity: params[:quantity])
    else
      render :status => 500
    end

  end


  def delete
    if IngredientRecipe.exists?(params[:id])
      IngredientRecipe.find(params[:id]).destroy
    else
       render :status => 500
    end
  end

end
