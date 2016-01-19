class IngredientRecipe < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe
  validates :recipe_id,:ingredient_id,:quantity,:unit, presence: true
end
