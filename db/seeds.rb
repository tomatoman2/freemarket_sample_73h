require "csv"

CSV.foreach('db/category.csv') do |row|
  Category.create(:level => row[0], :parent_id => row[1], :name => row[2])
end