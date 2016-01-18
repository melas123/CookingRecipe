class IngredientController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]

  def create
    @ingredient = Ingredient.new(name: params[:name])
    respond_to do |format|
      if @ingredient.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
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
