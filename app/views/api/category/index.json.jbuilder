json.array! @categories do |category|
  json.level category.level
  json.name category.name
  json.parent_id category.parent_id
  json.id category.id
end
