class IngredientController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]

  def create
    Ingredient.create(name: params[:name])
  end

  def index
    @ingredients = Ingredient.all
  end

  def update
    Ingredient.find( params[:id] ).update( name: params[:name] )
    
  end
  
  def destroy
    Ingredient.find(params[:id]).destroy
  end
end
