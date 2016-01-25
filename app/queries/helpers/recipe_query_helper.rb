class RecipeQueryHelper

  def initialize( query=nil )
    @query= Arel.sql("UNACCENT('%#{ query }%')" )
  end

  def search
    Recipe.where(
      recipes[ :title ].matches( "%#{@query}%" )
      .or(
        recipes[ :description ].matches( "%#{@query}%" )
      )
    )
  end

  protected
  def recipes
    Recipe.arel_table
  end
end
