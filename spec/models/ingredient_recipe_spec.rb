require 'rails_helper'

RSpec.describe IngredientRecipe, type: :model do
  it "has an ingredient and a recipe" do
  	r = Recipe.create!
  	ing = Ingredient.create!(:name => "Ing")
  	i = IngredientRecipe.new(:recipe => r,:ingredient => ing,:quantity => 2,:unit => "g")
  	expect(i).to be_valid
  end

  it "has no ingredient" do
  	r = Recipe.create!
  	ing = nil
  	i = IngredientRecipe.new(:recipe => r,:ingredient => ing,:quantity => 2,:unit => "g")
  	expect(i).to_not be_valid
  end

  it "has no recipe" do
  	r = nil
  	ing = Ingredient.create!(:name => "Ing")
  	i = IngredientRecipe.new(:recipe => r,:ingredient => ing,:quantity => 2,:unit => "g")
  	expect(i).to_not be_valid
  end

  it "has no quantity" do
	r = Recipe.create!
  	ing = Ingredient.create!(:name => "Ing")
  	i = IngredientRecipe.new(:recipe => r,:ingredient => ing,:quantity => nil,:unit => "g")
  	expect(i).to_not be_valid
  end

  it "has no unit" do
  	r = Recipe.create!
  	ing = Ingredient.create!(:name => "Ing")
  	i = IngredientRecipe.new(:recipe => r,:ingredient => ing,:quantity => 2,:unit => nil)
  	expect(i).to_not be_valid
  end
  
end
