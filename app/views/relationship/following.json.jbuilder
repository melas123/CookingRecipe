json.array!(@following) do |follower|
  json.id follower.id
  json.name follower.name
  json.email follower.email
end
