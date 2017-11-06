json.extract! review, :id, :content, :user_id, :item_id, :created_at, :updated_at
json.url review_url(review, format: :json)
