json.array!(@favorites) do |favorite|
  json.extract! favorite, :id
  json.url comment_url(favorite, format: :json)
end
