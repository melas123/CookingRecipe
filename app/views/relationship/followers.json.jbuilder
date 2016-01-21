json.array!(@followers) do |follower|
  json.email follower.email
end