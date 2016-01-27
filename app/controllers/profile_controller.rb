class ProfileController < ApplicationController
  before_filter :authenticate_user!, only: [ :create, :update, :destroy ]
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
    @favorites = User.find(current_user.id).favorites.all
  end
  #  post "profile/destroy_favorite"
  def destroy_favorite
    (Favorite.where( id: params[:favorite_id], user_id: current_user.id )).first.destroy
  end
end
