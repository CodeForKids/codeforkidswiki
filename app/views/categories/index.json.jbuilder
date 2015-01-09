json.array!(@categories) do |category|
  json.extract! category, :id, :name, :handle, :fontawesome, :number_of_pages
  json.extract! category, :created_at, :updated_at
  json.url show_category_url(category.handle, format: :json)
end



