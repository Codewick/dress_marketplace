json.extract! booking, :id, :user_id, :item_id, :start_date, :end_date, :created_at, :updated_at
json.url booking_url(booking, format: :json)
