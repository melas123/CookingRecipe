require 'rails_helper'

RSpec.describe IngredientRecipe, type: :model do

  it "has an ingredient and a recipe" do
  	expect(build(:ingredient_recipe, :valid)).to be_valid
  end

  it "has no ingredient" do
  	expect(build(:ingredient_recipe, :with_no_ingredient)).to_not be_valid
  end

  it "has no recipe" do
  	expect(build(:ingredient_recipe, :with_no_recipe)).to_not be_valid
  end

  it "has no quantity" do
  	expect(build(:ingredient_recipe, :valid,quantity: nil)).to_not be_valid
  end

  it "has no unit" do
  	expect(build(:ingredient_recipe, :valid,unit: nil)).to_not be_valid
  end
  
end
