FactoryBot.define do

  factory :product do
    name                {"商品名"}
    category_id         {1}
    brand_id            {1}
    brand_name          {"シャネル"}
    size                {"大きい"}
    price               {1000000}
    postage_code        {1}
    explanation         {"商品説明です。多少汚れが目立ちます"}
    status              {1}
    user_id             {1}
    prefecture_id       {1}
    delivery_time_code  {1}
  end 

end