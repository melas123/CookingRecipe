require 'rails_helper'

RSpec.describe IngredientController, type: :controller do
  render_views

  describe "GET #new" do
    
    it "add the ingredient" do
      name = Faker::SlackEmoji.food_and_drink
      post :new ,format: :json,name: name
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

  describe "GET #update" do
    let!(:ingredient) { create(:ingredient,:with_name) }

    it "change the ingredient name" do
      new_name = Faker::SlackEmoji.food_and_drink
      json = { format: 'json', name: new_name, id: ingredient.id }
      put :update,json
      expect(Ingredient.find(ingredient.id).name).to eq(new_name)
    end
  end

  describe "GET #delete" do
    let!(:ingredient) { create(:ingredient,:with_name) }

    it "deletes when a record is found" do
      json = { format: 'json', id: ingredient.id }
      delete :delete,json
      expect(response).to have_http_status(:success)
      expect(Ingredient.exists?(ingredient.id)).to be false
    end
  end


end
