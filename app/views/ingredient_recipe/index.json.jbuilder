json.array!(@ingredient_recipes) do |i|
  json.quantity      i.quantity
  json.measure       i.measure
  json.mass_unit     i.mass_unit
  json.volume_unit	 i.volume_unit  
  json.ingredient_id i.ingredient_id
end