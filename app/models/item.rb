class Item < ActiveRecord::Base
  include ImageUploader::Attachment.new(:image)
  belongs_to :user
end
