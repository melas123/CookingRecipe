json.array!(@following) do |follower|
  json.email follower.email
end