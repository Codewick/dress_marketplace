json.extract! profile, :id, :first_name, :last_name, :image_data, :street, :city, :state, :post_code, :longitude, :latitude, :created_at, :updated_at
json.url profile_url(profile, format: :json)
