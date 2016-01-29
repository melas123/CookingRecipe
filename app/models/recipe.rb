class Recipe < ActiveRecord::Base

  validates  :title, :description, presence: true

  belongs_to :user
  has_many   :ingredients, through: :ingredient_recipes
  has_many   :ingredient_recipes
  has_many   :images,    dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :comments,  dependent: :destroy
  has_many   :rates

  accepts_nested_attributes_for :images

  scope :most_recent, -> { order( created_at: :desc ) }

  def calculate_rate_for_recipe ()
    if rates.count == 0
      return 0
    else
      return rates.average(:value)
    end
  end

  #Override the as_json method to include the user name,ingredient_recipes:
  def as_json(options = {})
    super(options.merge(include: {
                            user: { only: [ :name,:id ] },
                            ingredient_recipes: { only: [:id, :quantity, :ingredient_id, :recipe_id, :mass_unit, :volume_unit, :measure] },
                            ingredients:        { only: [ :name,:id ] },
                            images:             { only: [ :avatar ]}
                                 }
          ))
  end
end
