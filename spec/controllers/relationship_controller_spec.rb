require 'rails_helper'

RSpec.describe RelationshipController, type: :controller do

  describe "POST #follow" do
    it "Does the job" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      followed = create( :user )
      follower = create( :user )
      sign_in follower
      post :follow, format: :json, followed_id: followed.id
      expect( Relationship.count ).to eq(1)
      expect( User.find( follower.id ).following.count ).to eq(1)
      expect( User.find( followed.id ).followers.count ).to eq(1)
    end

    it "Does not let user follow himself" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create( :user )
      sign_in user
      post :follow, format: :json, followed_id: user.id
      expect( Relationship.count ).to eq(0)
    end
  end 

  describe "POST #unfollow" do
    it "Does the job" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      followed     = create :user
      follower     = create :user
      relationship = create :relationship, follower: follower, followed: followed
      sign_in follower
      post :unfollow, format: :json, followed_id: followed.id
      expect( Relationship.count ).to eq(0)
    end
  end

  describe "GET #followers" do
    it "returns right followers" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      followed     = create :user
      follower     = create :user
      not_follower = create :user
      relationship = create :relationship, follower: follower, followed: followed
      get :followers, format: :json, user_id: followed.id
      expect( assigns[:followers] ).to     include( follower     )
      expect( assigns[:followers] ).to_not include( not_follower )
    end
  end

  describe "GET #following" do
    it "returns right following" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      followed     = create :user
      not_followed = create :user
      follower     = create :user
      relationship = create :relationship, follower: follower, followed: followed
      get :following, format: :json, user_id: follower.id
      expect( assigns[:following] ).to     include( followed     )
      expect( assigns[:following] ).to_not include( not_followed )
    end
  end

end
