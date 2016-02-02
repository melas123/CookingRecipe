class Image < ActiveRecord::Base
  validates      :avatar,:recipe, presence: true
  belongs_to     :recipe
  mount_uploader :avatar, ImagesUploader
end
