json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :callers_id, :receivers_id, :order_id, :call_type
  json.url meeting_url(meeting, format: :json)
end
