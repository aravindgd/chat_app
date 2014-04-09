json.array!(@receivers) do |receiver|
  json.extract! receiver, :id, :name, :number, :activation
  json.url receiver_url(receiver, format: :json)
end
