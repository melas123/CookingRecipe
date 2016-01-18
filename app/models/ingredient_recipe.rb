class IngredientRecipe < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe
  validates :recipe_id,:ingredient_id,:quantity, presence: true
  enum volume_unit: { ml: 1, cl: 2, litre: 3 }
  enum mass_unit: { g: 1, Kg: 2 }
  enum measure: { Mass: 1, Volume: 2, None:3}
  
  
  def as_json(options = {})
    super(options.merge( include: :ingredient ))
  end
  
end
