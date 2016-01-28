json.array!(@recipes_followed) do |recipe_followed|
  json.extract! recipe_followed, :id, :title, :description
end
