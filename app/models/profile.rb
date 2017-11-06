class Profile < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :user, optional: true

  validates :address, presence: true
  validates :post_code, presence: true


  geocoded_by :address
  after_validation :geocode

def full_address
  "#{address}, #{city}, #{state}, #{post_code}, Australia"
end

end
