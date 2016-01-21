require 'rails_helper'

RSpec.describe IngredientController, type: :controller do
  render_views

  describe "POST #create" do
    it "adds the ingredient if signed in" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user

      name = Faker::SlackEmoji.food_and_drink
      post :create ,format: :json,name: name
      expect(response).to have_http_status(:success)
      expect(Ingredient.find_by_name(name)).to_not be_nil
    end
  end

  describe "GET #index" do
    let!(:ingredient)  { create(:ingredient,:with_name,name: Faker::SlackEmoji.food_and_drink) }
    let!(:ingredient2) { create(:ingredient,:with_name,name: "Another name") }

    it "returns added ingredients" do
      get :index,format: :json
      expect(assigns[:ingredients]).to include(ingredient)
    end
  end

  describe "PUT #update" do
    let!(:ingredient) { create(:ingredient,:with_name) }

    xit "change the ingredient name" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user

      new_name = Faker::SlackEmoji.food_and_drink
      json = { format: 'json', name: new_name, id: ingredient.id }
      put :update,json
      expect(Ingredient.find(ingredient.id).name).to eq(new_name)
    end
  end

  describe "DELETE #destroy" do
    let!(:ingredient) { create(:ingredient,:with_name) }

    xit "destroy when a record is found" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user


      json = { format: 'json', id: ingredient.id }
      delete :destroy,json
      expect(response).to have_http_status(:success)
      expect(Ingredient.exists?(ingredient.id)).to be false
    end
  end


end
