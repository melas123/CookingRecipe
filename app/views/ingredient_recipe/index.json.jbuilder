json.array!(@ingredient_recipes) do |i|
  json.quantity      i.quantity
  json.unit          i.unit
  json.ingredient_id i.ingredient_id
end