class Recipe < ActiveRecord::Base
  validates :title,:description, presence: true
  belongs_to :user
  has_many :ingredient_recipes
  has_many :images
end
