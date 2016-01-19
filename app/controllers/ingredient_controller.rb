class IngredientController < ApplicationController
  def new
    if params[:name]
      ingredient = Ingredient.create(name: params[:name])
      if ingredient.valid?
        
      else
        render status: 500
      end
    else
      render status: 500
    end
  end

  def index
    @ingredients = Ingredient.all
  end

  def update
    if params[:id] and params[:name]
      
      if Ingredient.exists?(params[:id])
        Ingredient.find( params[:id] ).update( name: params[:name] )
      else
        render status: 500
      end
    else
      render status: 500
    end
  end

  def delete
    if params[:id]
      if Ingredient.exists?(params[:id])
        Ingredient.find(params[:id]).destroy
      else
        render status: 500
      end
    else
      render status: 500
    end
  end
end
