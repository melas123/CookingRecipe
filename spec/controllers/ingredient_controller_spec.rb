require 'rails_helper'
RSpec.describe IngredientController, type: :controller do

  let!( :ingredient ) { create( :ingredient, :with_name ) }

  describe "POST #create" do
    login_user
    it "adds the ingredient if signed in" do
      name = Faker::SlackEmoji.food_and_drink
      post :create ,format: :json,name: name
      expect( response ).to have_http_status( :success )
      expect( Ingredient.where( name: name ) ).to_not be_nil
    end
  end

  describe "GET #index" do
    let!( :ingredient1 )  { create( :ingredient, :with_name, name: Faker::SlackEmoji.food_and_drink ) }
    let!( :ingredient2 ) { create( :ingredient, :with_name, name: "Another name" ) }

    it "returns added ingredients" do
      get :index,format: :json
      expect( assigns[ :ingredients ] ).to include( ingredient1 )
    end
  end

  describe "DELETE #destroy" do
    login_user
    it "destroy when a record is found" do
      json = { format: 'json', id: ingredient.id }
      delete :destroy,json
      expect( response ).to have_http_status( :success )
      expect( Ingredient.exists?( ingredient.id ) ).to be false
    end
  end
end
