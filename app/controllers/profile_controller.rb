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
  #  post "profile/destroy_favorite"
  def destroy_favorite
    Favorite.where( id: params[:favorite_id], user_id: current_user.id ).first.destroy
  end
end
