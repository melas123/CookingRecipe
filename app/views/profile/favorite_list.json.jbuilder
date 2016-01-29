json.array!(@favorites) do | favorite |
  json.extract! favorite, :id, :title, :description
end
