class Recipe < ActiveRecord::Base
  validates :title,:description, presence: true
  belongs_to :user
end
