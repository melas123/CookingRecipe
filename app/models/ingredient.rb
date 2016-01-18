class Ingredient < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	has_many :ingredient_recipes
end
