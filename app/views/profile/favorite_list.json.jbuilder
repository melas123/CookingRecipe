json.array!(@favorites) do | favorite |
  json.extract! favorite, :id, :title, :description
  json.url comment_url(favorite, format: :json)
end
