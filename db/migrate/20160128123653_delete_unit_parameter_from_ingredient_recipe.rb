class DeleteUnitParameterFromIngredientRecipe < ActiveRecord::Migration
  def change
    remove_column :ingredient_recipes, :unit
  end
end
