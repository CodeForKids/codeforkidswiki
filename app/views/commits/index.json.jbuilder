json.array!(@commits) do |commit|
  json.extract! commit, :id, :page_id, :message
  json.user do
    json.first_name commit.user.first_name
    json.last_name commit.user.last_name
    json.avatar commit.user.avatar
    json.username commit.user.username
    json.email commit.user.email
  end
  json.extract! commit, :created_at, :updated_at
end
