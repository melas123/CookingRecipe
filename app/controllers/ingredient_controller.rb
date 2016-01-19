class IngredientController < ApplicationController
  def new
    Ingredient.create(name: params[:name])
  end

  def index
    @ingredients = Ingredient.all
  end

  def update
    Ingredient.find( params[:id] ).update( name: params[:name] )
    
  end
  
  def delete
    Ingredient.find(params[:id]).destroy
  end
end
