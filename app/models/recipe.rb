class Recipe < ActiveRecord::Base
  validates :title, :description, presence: true

  belongs_to :user
  has_many :ingredients, through: :ingredient_recipes
  has_many :ingredient_recipes

  has_many :images
  has_many :comments
  has_many :rates

  scope :most_recent, -> ( page ) { order( created_at: :desc ).paginate( page: page, per_page: 10 ) }
  scope :search, -> ( query ) { RecipeQueryHelper.new( query ).search }

  def calculate_rate_for_recipe ()
    if rates.count == 0
      return 0
    else
      return rates.average(:value)
    end
  end

  #Override the as_json method to include the user name:
  def as_json(options = {})
    super(options.merge(include: {
                            user: { only: [ :name,:id ] }
                                 }
          ))
  end

  def self.recipe
    self.arel_table
  end
end
