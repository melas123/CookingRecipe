require 'rails_helper'
RSpec.describe RecipeController, type: :controller do
    before( :each ) do
      request.env[ "HTTP_ACCEPT" ] = "application/json"
    end
    let!( :recipe_created ) { create( :recipe ) } # saved in db
    let!( :recipes_created ) { create_list( :recipe, 30 ) } #save a list of recipe

    # Current user
    #------------------------------------------------
    describe "Get the current user" do
      login_user
      it "should have a current_user" do
        expect( subject.current_user ).to_not eq nil
      end
    end
    # CRUD Recipe
    #------------------------------------------------
    describe "CRUD" do
      # For logged in User
      # ---------------------------------------------
      context "if user logged in" do
        #create recipe
        login_user
        it "create user recipe" do
          post :create, format: :json, recipe: FactoryGirl.attributes_for( :recipe )
          expect( assigns( :userRecipe ) ).to_not eq nil
          expect( assigns( :userRecipe ).user_id ).to eq( subject.current_user.id )
          #recipe created
          expect( response.status ).to eq 201
        end
        #delete recipe
        it "detele user recipe" do
          delete :destroy, format: :json, id: recipe_created.id
          expect( response.status ).to eq( 200 )
          expect( response.message ).to eq( 'OK' )
        end
        #update recipe
        it "update user recipe" do
          put :update, format: :json, id: recipe_created.id, title: 'title test update', description: 'description test update'
          expect( Recipe.find( recipe_created.id ).title ).to  eq( 'title test update' )
        end
      end
      # For non-logged in User
      # ---------------------------------------------
      context "user log out" do
        before( :each ) do
          @recipe_attributes = FactoryGirl.attributes_for :recipe
        end
        #try to create  without authentification
        it "post request without authentification" do
            post :create, format: :json, recipe: @recipe_attributes
            expect( response.status ).to eq 401
        end
        #try to update recipe without authentification
        it "put request without authentification" do
          put :update, format: :json, id: recipe_created.id
          expect( response.status ).to eq 401
        end
        #try to update recipe without authentification
        it "put request without authentification" do
          delete :destroy, format: :json, id: recipe_created.id
          expect( response.status ).to eq 401
        end
      end
      # For all users
      # ---------------------------------------------
      context "for all users" do
        describe "Get #show" do
          # show recipe
          # ---------------------------------------------
          it "return recipe details" do
            get :show, format: :json, id: recipe_created.id
            expect( assigns( :recipe ).title ).to eq recipe_created.title
          end
        end
        # paginate recipes
        # ---------------------------------------------
        describe "Get All recipes with pagination" do

          it 'return recipes : 10 per page 'do
            get :index, format: :json, page: 2
            expect( assigns( :recipes ).length ).to eq 10
          end

          it 'should sort recipes by date of publication' do
            get :index, format: :json
            expect( assigns( :recipes )[ 0 ] ).to eq Recipe.most_recent(1).first
          end
        end
        # search for recipe
        # ---------------------------------------------
        it 'if search == nil : return the 10 first recipes' do
          get :index, format: :json, search: nil, page: 1
          expect( assigns( :recipes ).length ).to eq 10
        end
        it 'search for recipe by: title' do
          searchedTitle = Recipe.last.title
          get :index, format: :json, search: searchedTitle, page: 1
          expect( assigns( :recipes ) ).to eq searchedTitle
        end

      end
    end
end
