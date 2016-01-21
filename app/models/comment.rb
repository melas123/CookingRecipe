class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  validates :user,:recipe,:text, presence: true
end
