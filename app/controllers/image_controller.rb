class ImageController < ApplicationController
  respond_to :json
  def create
      Image.create(title: params[:title],url: params[:url],recipe: Recipe.find(params[:recipe_id]))
  end

  def index
      @images = Recipe.find(params[:recipe_id]).images.all
  end

  def destroy
      Image.find(params[:id]).destroy
  end

  def update
      Image.find(params[:id]).update(title: params[:title])
  end
end
