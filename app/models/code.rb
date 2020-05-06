class Code < ActiveHash::Base
  self.data = [
      {id:1, group_id:100, group_name:"商品の状態", code_id:0, code_name:"新品、未使用"},
      {id:2, group_id:100, group_name:"商品の状態", code_id:1, code_name:"未使用に近い"},
      {id:3, group_id:100, group_name:"商品の状態", code_id:2, code_name:"目立った傷や汚れなし"},
      {id:4, group_id:100, group_name:"商品の状態", code_id:3, code_name:"やや傷や汚れあり"},
      {id:5, group_id:100, group_name:"商品の状態", code_id:4, code_name:"傷や汚れあり"},
      {id:6, group_id:100, group_name:"商品の状態", code_id:5, code_name:"全体的に状態が悪い"},
      {id:7, group_id:101, group_name:"配送料の負担", code_id:0, code_name:"送料込み（出品者負担）"},
      {id:8, group_id:101, group_name:"配送料の負担", code_id:1, code_name:"着払い（購入者負担）"},
      {id:9, group_id:102, group_name:"発送までの日数", code_id:0, code_name:"1~2日で発送"},
      {id:10, group_id:102, group_name:"発送までの日数", code_id:1, code_name:"2~3日で発送"},
      {id:11, group_id:102, group_name:"発送までの日数", code_id:2, code_name:"4~7日で発送"}
  ]
  def self.group_search(group_id)
    Code.where(group_id: group_id)
  end
end