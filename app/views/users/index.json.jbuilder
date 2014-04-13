json.array!(@users) do |user|
  json.extract! user, :id, :external_caller_id, :external_receiver_id
  json.url user_url(user, format: :json)
end
