class RecipeController < ApplicationController
  #call `get_recipe` method before
  before_action :get_recipe , only: [ :update,:show,:destroy ]

  #only authenticated users can create or update recipe
  before_filter :authenticate_user!, only: [ :create, :update, :destroy ]
  respond_to :json

  #Show all recipes
  def index
    #return all recipes sorted by date of publication.
    @recipes = Recipe.most_recent.paginate( page: params[ :page ], per_page: 10 )
    #byebug
    respond_with( Paginator.pagination_attributes( @recipes ).merge!( recipes:  @recipes ), status: 200 )
  end

  def create_favorite
    Favorite.create user_id: current_user.id, recipe_id: params[:recipe_id]
  end

  def rate
    @rate = Recipe.find(params[:recipe_id]).calculate_rate_for_recipe
  end
  #Create new recipe
  #POST /recipes.json
  def create
    @userRecipe = Recipe.new( recipe_params.merge( user_id: current_user.id ) )
    @userRecipe.save
    
    respond_with( @userRecipe )
  end

  #Update recipe with given :id
  #PUT /recipes/:id.json
  def update
    respond_with @recipe.update( description: params[ :description ], title: params[ :title ] )
  end

  #Delete recipe with given :id
  #DELETE /recipes/:id.json
  def destroy
    if @recipe.present?
      @recipe.destroy
      render json: { status: 200, message: 'OK' }
    else
      render json: { status: 404, message: 'error' }
    end
  end

  #Show recipe with given :id
  #GET recipes/:id.json
  def show
    respond_with @recipe
  end



  private
  def get_recipe
    @recipe = Recipe.where( id: params[ :id ] ).try :first
  end

  private
  def recipe_params
    params.require( :recipe ).permit( :title, :description)
  end


end
