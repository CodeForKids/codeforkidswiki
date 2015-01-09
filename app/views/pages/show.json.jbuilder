json.extract! @page, :id, :title, :content, :handle, :did_help, :did_not_help, :sticky, :category_id
json.most_common_committer do
  json.first_name @page.most_common_committer.first_name
  json.last_name @page.most_common_committer.last_name
  json.avatar @page.most_common_committer.avatar
  json.username @page.most_common_committer.username
  json.email @page.most_common_committer.email
end
json.extract! @page, :created_at, :updated_at
