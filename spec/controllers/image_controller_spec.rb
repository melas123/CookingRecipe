require 'rails_helper'

RSpec.describe ImageController, type: :controller do
  let!( :recipe ) { create( :recipe ) }
  describe "POST create" do
    it "adds image when it's valid" do
      post :create,format: :json, title: "title", recipe_id: recipe.id, avatar: File.open("public/images.jpg")
      expect(response).to have_http_status( :success )
    end
  end

  describe "GET index" do
    it "shows images when it gets a recipe id" do
      create_list( :image_with_valid_avatar, 10, recipe: recipe )
      get :index, format: :json, recipe_id: recipe.id
      expect( assigns[ :images ].length ).to eq( 10 )
    end
  end

  describe "GET delete" do
  let!( :image_with_valid_avatar ) { create( :image_with_valid_avatar ) }

    it "deletes image when it gets an image id" do
      get :destroy,format: :json,id: image_with_valid_avatar.id,recipe_id: nil
      expect( response ).to have_http_status( :success )
      expect( Image.exists?( image_with_valid_avatar.id ) ).to be false
    end
  end

  describe "PUT update" do
    let!( :image_with_valid_avatar ) { create( :image_with_valid_avatar ) }
    it "it changes the image title" do
      put :update,format: :json,id: image_with_valid_avatar.id, title:"test"
      expect( Image.find( image_with_valid_avatar.id ).title ).to eq "test"
    end
  end
end
