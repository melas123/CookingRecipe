class AddMeasureToIngredientRecipes < ActiveRecord::Migration
  def change
    add_column :ingredient_recipes, :measure, :integer
  end
end
