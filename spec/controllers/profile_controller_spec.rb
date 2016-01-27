require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  #save new favorite in db
  let!( :favorite_created ) { create( :favorite ) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #destroy_favorite" do
    login_user
    it "delete Favorite" do
    #  favorite = create :favorite, user_id: current_user.id
      post :destroy_favorite, format: :json, favorite_id: favorite_created.id
      expect( Favorite.count ).to eq(0)
    end
  end
end
