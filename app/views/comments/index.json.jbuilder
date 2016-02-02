json.array!(@comments) do |comment|
  json.extract! comment, :id, :text, :user_id, :created_at
  json.extract! comment.user, :name
end
