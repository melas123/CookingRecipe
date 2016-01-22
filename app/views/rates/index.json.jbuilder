json.array!(@rates) do |rate|
  json.extract! rate, :id
  json.url rate_url(rate, format: :json)
end
