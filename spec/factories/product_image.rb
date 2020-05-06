FactoryBot.define do

  factory :product_image do
    image_name {File.open("#{Rails.root}/public/uploads/product_image/image_name/test.png")}
    product_id {1}
    product
  end 

end