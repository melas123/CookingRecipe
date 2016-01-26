class Recipe < ActiveRecord::Base

  validates :title, :description, presence: true

  belongs_to :user
  has_many :ingredient_recipes
  has_many :images
  has_many :favorites, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  scope :most_recent, -> { order( created_at: :desc ) }
  has_many :rates


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
end
