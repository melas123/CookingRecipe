class ProfileController < ApplicationController
  before_filter :authenticate_user!, only: [ :create, :update, :destroy, :favorite_list ]
  respond_to :json

  def index
    #return recipes's current_user.
    if user_signed_in?
      @recipesUser = Recipe.where(user_id: current_user.id).most_recent.paginate( page: params[ :page ], per_page: 10 )
      #byebug
      respond_with( Paginator.pagination_attributes( @recipesUser ).merge!( recipes:  @recipesUser ), status: 200 )
    end
  end
  #  get "profile/favorite_list"
  def favorite_list
    @favorites = Recipe.where( id: current_user.favorites.pluck( :recipe_id ) )
  end
  #  get "profile/isFavorite"
  def isFavorite
    @isFavorite = false
    @favorite  = Favorite.where(user_id: current_user.id, recipe_id: params[:recipe_id])
    if @favorite.present?
      @isFavorite = true
    end
    render json: @isFavorite
  end

  #  get "profile/find_user"
  def find_user
    @user = User.where(id: params[:user_id])
    render json: @user
  end

  #  get "profile/recipes_user"
  def recipes_user
    @recipes = User.find(params[:user_id]).recipes
    render json: @recipes
  end

  #  post "profile/create_favorite"
  def create_favorite
    @favorite  = Favorite.new(user_id: current_user.id, recipe_id: params[:recipe_id])
    @favorite.save
  end
  #  post "profile/destroy_favorite"
  def destroy_favorite
    Favorite.where( recipe_id: params[:recipe_id], user_id: current_user.id ).destroy_all
  end
end
