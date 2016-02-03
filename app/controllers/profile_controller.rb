class ProfileController < ApplicationController
  before_filter :authenticate_user!, only: [ :create, :update, :destroy ]
  respond_to :json
  def index
    #return recipes's current_user.
    if user_signed_in?
      @recipesUser = Recipe.where(user_id: current_user.id).most_recent.paginate( page: params[ :page ], per_page: 10 )
      respond_with( Paginator.pagination_attributes( @recipesUser ).merge!( recipes:  @recipesUser ), status: 200 )
    end
  end
end
