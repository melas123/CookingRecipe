json.array!(@ingredients) do |i|
  json.id     i.id
  json.name   i.name
end