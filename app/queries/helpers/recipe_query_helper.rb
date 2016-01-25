class RecipeQueryHelper

  def initialize( query=nil )
    @query = query #Arel.sql( "UNACCENT('%#{ query }%')" )
  end

  def search_recipe_helper
    Recipe.where(
      recipes[ :title ].matches( "%#{@query}%" )
      .or(
        recipes[ :description ].matches( "%#{@query}%" )
      ).or(
        recipes[ :id ].in(
                      self.get_matched_ingredients
        )
      )
    )
  end

  def get_matched_ingredients
    Ingredient.where(
      ingredients[ :name ].matches( "%#{@query}%" )
    ).find_each do |ingredient|
      return ingredient.ingredient_recipes.pluck(:recipe_id)
    end
  end

  protected
  def recipes            ;  Recipe.arel_table            ; end
  def ingredients        ;  Ingredient.arel_table        ; end
  def ingredient_recipes ;  IngredientRecipe.arel_table  ; end

end
