require 'rails_helper'
RSpec.describe CommentsController, type: :controller do

  let!( :user ){ create :user  }
  let!( :recipe ){ create :recipe  }
  let!( :comment ) { create :comment, :valid }
  describe "GET #index" do
    it "returns all comments of a recipe" do
      recipe_with_comments = create :recipe
      comment1 = create :comment, :valid, recipe: recipe_with_comments
      comment2 = create :comment, :valid, recipe: recipe_with_comments

      get :index, { format: :json, recipe_id: recipe_with_comments.id }
      expect( assigns( :comments ) ).to eq( [ comment1, comment2 ] )
    end
  end

  describe "GET #show" do
    it "assigns the requested comment as @comment" do
      get :show, { format: :json, id: comment.id }
      expect( assigns( :comment ) ).to eq( comment )
    end
  end


  describe "POST #create" do
    login_user
    it "creates a new Comment" do
      expect {
        post :create, { format: :json, recipe_id: recipe.id, text: Faker::Lorem.paragraph }
      }.to change( Comment, :count ).by( 1 )
    end
  end

  describe "PUT #update" do
    it "updates the requested comment" do
      @request.env[ "devise.mapping" ] = Devise.mappings[ :user ]
      user = FactoryGirl.create( :user )
      sign_in user
      comment = create :comment, :valid, user: user

      new_text = Faker::Lorem.paragraph + " CHANGED"
      put :update, { format: :json, id: comment.id, text: new_text, user_id: comment.user_id, recipe_id: comment.recipe_id }
      expect( Comment.find( comment.id ).text ).to eq( new_text )
    end

    it "doesn't update a comment of another user" do
      @request.env[ "devise.mapping" ] = Devise.mappings[ :user ]
      user1 = FactoryGirl.create( :user )
      user2 = FactoryGirl.create( :user )
      comment = create :comment, :valid, user: user1
      sign_in user2

      old_text = comment.text
      new_text = Faker::Lorem.paragraph + " CHANGED"
      put :update, { format: :json, id: comment.id, text: new_text }
      expect( Comment.find( comment.id ).text ).to eq( old_text )
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      @request.env[ "devise.mapping" ] = Devise.mappings[ :user ]
      user = FactoryGirl.create( :user )
      comment = create :comment, :valid, user: user
      sign_in user

      expect {
        delete :destroy, { format: :json, id: comment.id }
      }.to change( Comment, :count ).by( -1 )
    end

    it "destroys the comment if he's the owner of the recipe" do
      @request.env[ "devise.mapping" ] = Devise.mappings[ :user ]

      recipe_owner = FactoryGirl.create( :user )
      recipe = FactoryGirl.create( :recipe, user: recipe_owner )

      comment_owner = FactoryGirl.create( :user )
      comment = create :comment, :valid, user: comment_owner, recipe: recipe
      sign_in recipe_owner

      expect {
        delete :destroy, { format: :json, id: comment.id }
      }.to change( Comment, :count ).by( -1 )
    end

    it "doesn't delete a comment of another user and he's not the owner of recipe" do
      @request.env[ "devise.mapping" ] = Devise.mappings[ :user ]
      comment_owner = FactoryGirl.create( :user )
      stranger = FactoryGirl.create( :user )
      recipe_owner = FactoryGirl.create( :user )
      recipe = create :recipe, user: recipe_owner
      comment = create :comment, :valid, user: comment_owner, recipe: recipe
      sign_in stranger
      expect {
        delete :destroy, { format: :json, id: comment.id }
      }.to change( Comment, :count ).by( 0 )
    end
  end
end
