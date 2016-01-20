class Image < ActiveRecord::Base
  validates :url,:recipe, presence: true
  belongs_to :recipe
end
