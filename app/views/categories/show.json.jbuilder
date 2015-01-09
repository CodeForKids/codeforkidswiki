json.extract! @category, :id, :name, :handle, :fontawesome, :number_of_pages
json.extract! @category, :created_at, :updated_at
json.per_pagination @per_page.to_i
json.pagination_number @page_number.to_i
json.pages do
  json.partial! 'pages/pages', pages: @pages
end
