class AddMassUnitToIngredientRecipes < ActiveRecord::Migration
  def change
    add_column :ingredient_recipes, :mass_unit, :integer
  end
end
