class AddQuantityNumberToIngredientRecipe < ActiveRecord::Migration
  def change
  	add_column :ingredient_recipes, :quantity, :float
  	add_column :ingredient_recipes, :unit,     :string
  end
end
