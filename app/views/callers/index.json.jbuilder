json.array!(@callers) do |caller|
  json.extract! caller, :id, :name, :number, :activation
  json.url caller_url(caller, format: :json)
end
