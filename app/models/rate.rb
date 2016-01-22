class Rate < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user

  validates_numericality_of :value, less_than: 6, greater_than: -1
  validates :recipe, :user, presence: true
  validates_uniqueness_of :recipe, scope: :user 

end
