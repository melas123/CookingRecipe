class AddVolumeUnitToIngredientRecipes < ActiveRecord::Migration
  def change
    add_column :ingredient_recipes, :volume_unit, :integer
  end
end
