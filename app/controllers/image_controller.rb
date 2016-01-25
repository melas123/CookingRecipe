class ImageController < ApplicationController
  respond_to :json

  def create
    recipe_id     = params[ :recipe_id ]
    recipe        = Recipe.find( recipe_id )
    @image        = Image.new( avatar: params[ :avatar ], recipe: recipe, title: params[ :image_name ] )
    @image.save
    render 'create', formats: [ :json ], status: 201
  end

  def index
    @images = Recipe.find( params[ :recipe_id ] ).images.all
  end

  def destroy
    Image.find( params[:id] ).destroy
  end

  def update
    @image = Image.find( params[:id] ).update( title: params[ :title ] )
  end
end
