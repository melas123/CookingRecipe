require 'rails_helper'

RSpec.describe IngredientRecipeController, type: :controller do
  render_views


  let!(:recipe) { create(:recipe) }
  let!(:ingredient) { create(:ingredient,:with_name) }
  let!(:ingredient_recipe) { create(:ingredient_recipe, :valid)}


  describe "GET #new" do
    it "adds" do
      post :new, format: :json,:recipe_id => recipe.id,:ingredient_id => ingredient.id,:quantity => 1,:unit => "g"
      expect(response).to have_http_status(:success)
      expect(IngredientRecipe.find_by_quantity(1)).to_not be_nil
    end
  end

  describe "GET #index" do
    let!(:ingredient_recipe_in_recipe) { create(:ingredient_recipe,:valid,ingredient: ingredient_recipe.ingredient,quantity: 1) } 
    let!(:ingredient_recipe_out_recipe) { create(:ingredient_recipe,:valid,ingredient: ingredient_recipe.ingredient,quantity: 2) }
    it "display the added record" do
      get :index, format: :json,:recipe_id => ingredient_recipe.recipe.id
      expect(assigns[:ingredient_recipes]).to include(ingredient_recipe)

    end

    it "doesn't display foriegn records" do
      get :index, format: :json,:recipe_id => ingredient_recipe_in_recipe.recipe.id
      expect(assigns[:ingredient_recipes]).to include(ingredient_recipe_in_recipe)
      expect(assigns[:ingredient_recipes]).to_not include(ingredient_recipe_out_recipe)
    end

    it "returns the right ingredient_recipes for a recipe" do
      get :index, format: :json,:recipe_id => ingredient_recipe_in_recipe.recipe.id
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(1)
      expect(response.body).to include(ingredient_recipe_in_recipe.quantity.to_s)
      expect(response.body).to_not include(ingredient_recipe_out_recipe.quantity.to_s)
    end

  end

  describe "GET #delete" do
     it "deletes when a record is found" do
      json = { :format => 'json', :id => ingredient_recipe.id }
      delete :delete,json
      expect(response).to have_http_status(:success)
      expect(IngredientRecipe.exists?(ingredient_recipe.id)).to be false
    end

  end

  describe "GET #update" do
    it "change the ingredient unit" do
      new_quantity = ingredient_recipe.quantity+1
      json = { format: 'json', quantity: new_quantity, :id => ingredient_recipe.id }
      put :update,json
      expect(IngredientRecipe.find(ingredient_recipe.id).quantity).to eq(new_quantity)
    end
  end

end
