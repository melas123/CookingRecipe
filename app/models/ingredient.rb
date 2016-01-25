class Ingredient < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :recipes, through: :ingredient_recipes
	has_many :ingredient_recipes
end
