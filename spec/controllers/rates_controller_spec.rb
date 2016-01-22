require 'rails_helper'

RSpec.describe RatesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Rate. As you add validations to Rate, be sure to
  # adjust the attributes here as well.
  let!(:recipe) { create(:recipe) }
  let!(:user){ create :user  }
  let!(:rate) { create :rate, :valid } 
  describe "GET #index" do
    it "return global rating for a recipe " do
      rate = FactoryGirl.create(:rate, :valid, recipe_id: recipe.id)
      get :index, {format: :json, recipe_id: recipe.id}
      expect(assigns(:rates)).to eq(rate)
    end
  end

  describe "GET #show" do
    it "assigns the requested rate as @rate" do
      get :show, { format: :json, id: rate.id }
      expect(assigns(:rate)).to eq(rate)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      it "creates a new Rate" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
        expect {
          post :create, {format: :json, value: rand(5),recipe_id: recipe.id}
        }.to change(Rate, :count).by(1)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested rate" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        rate = FactoryGirl.create(:rate, :valid, user: user, recipe: recipe)
        sign_in user
        new_value = (rate.value + 1) % 6
        put :update, {format: :json, id: rate.id, value: new_value, user_id: rate.user_id,
         recipe_id: rate.recipe_id }
        expect(Rate.find(rate.id).value).to eq(new_value)
      end

      it "doesn't update a rate of another user" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        rate_owner = FactoryGirl.create(:user)
        stranger = FactoryGirl.create(:user)
        rate  = FactoryGirl.create(:rate, :valid, user: rate_owner, recipe: recipe )
        sign_in stranger
        old_value = rate.value
        new_value = (rate.value + 1) % 6
        put :update, {format: :json, id: rate.id, value: new_value } 
        expect(Rate.find(rate.id).value).to eq(old_value)
      end
    end

  end

  describe "DELETE #destroy" do
    it "destroys the requested rate" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      rate = create :rate, :valid, user: user
      sign_in user
      expect {
        delete :destroy, {format: :json, id: rate.id}
      }.to change(Rate, :count).by(-1)
    end
  end

end
