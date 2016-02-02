class CommentsController < ApplicationController

  before_action :set_comment, only: [:update, :destroy]
  before_filter :authenticate_user!, only: [:create, :update, :destroy]

  # GET /comments.json
  def index
    @comments = Recipe.find(params[:recipe_id]).comments.all.order('created_at DESC')
  end

  # POST /comments.json
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(text: params[:text], user_id: current_user.id, recipe_id: params[:recipe_id])
    #byebug
    @comment.save
    render json: @comment
  end

   # PATCH/PUT /comments/1.json
  def update
    if @comment.user_id == current_user.id
      @comment.update( text: params[:text] )
    end
  end

   # DELETE /comments/1.json
  def destroy
    if @comment.user_id == current_user.id or @comment.recipe.user_id == current_user.id
      @comment.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end


end
