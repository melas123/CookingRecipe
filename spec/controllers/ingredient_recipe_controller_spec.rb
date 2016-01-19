require 'rails_helper'

RSpec.describe IngredientRecipeController, type: :controller do
  render_views

  describe "GET #new" do

    it "adds" do
      r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      post :new, format: :json,:recipe_id => r.id,:ingredient_id => ing.id,:quantity => 1,:unit => "g"
       expect(response).to have_http_status(:success)
      expect(IngredientRecipe.find_by_quantity(1)).to_not be_nil
    end

    it "returns error when recipe missing" do
      ing = Ingredient.create!(:name => "Ing")
      post :new, format: :json,:recipe_id => nil,:ingredient_id => ing.id,:quantity => 1,:unit => "g"
       expect(response).to have_http_status(500)
    end

    it "returns error when ingredient missing" do
       r = Recipe.create!
      post :new, format: :json,:recipe_id => r.id,:ingredient_id => nil,:quantity => 1,:unit => "g"
      expect(response).to have_http_status(500)

    end
    it "returns error when quantity missing" do
       r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      post :new, format: :json,:recipe_id => r.id,:ingredient_id => ing.id,:quantity => nil,:unit => "g"
      expect(response).to have_http_status(500)

    end
    it "returns error when quantity missing" do
       r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      post :new, format: :json,:recipe_id => r.id,:ingredient_id => ing.id,:quantity => 1,:unit => nil
      expect(response).to have_http_status(500)

    end
  end

  describe "GET #index" do

    it "display the added record" do
      r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      ir = IngredientRecipe.create!(:recipe => r,:ingredient => ing,:quantity => 2,:unit => "g")
      get :index, format: :json,:recipe_id => r.id
      expect(assigns[:ingredient_recipes]).to include(ir)

    end

    it "doesn't display foriegn atttributes" do
      r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      ir = IngredientRecipe.create!(:recipe => r,:ingredient => ing,:quantity => 212,:unit => "g")
      r2 = Recipe.create!
      ir2 = IngredientRecipe.create!(:recipe => r2,:ingredient => ing,:quantity => 2,:unit => "g")
      get :index, format: :json,:recipe_id => r.id
      expect(assigns[:ingredient_recipes]).to include(ir)
      expect(assigns[:ingredient_recipes]).to_not include(ir2)
    end

    it "returns the right ingredient_recipes for a recipe" do
      r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      ir = IngredientRecipe.create!(:recipe => r,:ingredient => ing,:quantity => 123,:unit => "g")
      r2 = Recipe.create!
      ir2 = IngredientRecipe.create!(:recipe => r2,:ingredient => ing,:quantity => 321,:unit => "g")
      get :index, format: :json,:recipe_id => r.id
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(1)
      expect(response.body).to include(ir.quantity.to_s)
      expect(response.body).to_not include(ir2.quantity.to_s)
      expect(response.body).to_not include(ir2.quantity.to_s)

    end

  end

  describe "GET #delete" do
     it "deletes when a record is found" do
      r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      ir = IngredientRecipe.create!(:recipe => r,:ingredient => ing,:quantity => 2,:unit => "g")
      json = { :format => 'json', :id => ir.id }
      delete :delete,json
      expect(response).to have_http_status(:success)
      expect(IngredientRecipe.exists?(ir.id)).to be false
    end

    it "no existant id" do
      #we know that there's no record with an id = 1324
      json = { :format => 'json', :id => 1324 }
      delete :delete,json
      expect(response).to have_http_status(500)
    end
  end

  describe "GET #update" do
    it "change the ingredient unit" do
      r = Recipe.create!
      ing = Ingredient.create!(:name => "Ing")
      ir = IngredientRecipe.create!(:recipe => r,:ingredient => ing,:quantity => 2,:unit => "g")
      
      json = { format: 'json', quantity: 3, :id => ir.id }
      put :update,json
      expect(IngredientRecipe.find(ir.id).quantity).to eq(3)
    end

    it "gets no id" do 
      json = { format: 'json', id: nil }
      put :update,json
      expect(response).to have_http_status(500)
    end


    it "no existant id" do
      #we know that there's no record with an id = 1324
      json = { format: 'json', id: 1324 }
      put :update,json
      expect(response).to have_http_status(500)
    end
  end

end
