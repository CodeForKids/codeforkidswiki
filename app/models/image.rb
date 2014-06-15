class Image < ActiveRecord::Base
  mount_uploader :image, TinymceUploader
end
