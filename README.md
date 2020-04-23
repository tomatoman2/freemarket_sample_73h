
## userテーブル
|Column |Type |Option|
|------------|------|----------|
|nickname |string |null: false|
|password |string |null: false|
|name |string |null: false
|kana_name |string |null:false|
|birthday |datetime |null: false|

### Association
- has_many :credit_cards
- has_many:address
- has_many:likes
- has_many:coments
- has_many:Products
- has_many:order

## products
|Column|Type|Options|
|------|----|-------|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer| foreign_key: true|
|brand_name|string||
|size|string||
|price|decimal|null: false|
|postage_code|integer|null: false, foreign_key: true|
|explanation|text|null: false|
|status|string|null: false|
|user_id|integer| foreign_key: true|
|prefecture_id|integer|null: false|
|delivery_time_code|integer|null: false|

### Association
- has_many :likes
- has_many :comments
- has_many :product_images
- belongs_to :order
- belongs_to :user
- belongs_to :brand
- belongs_to :category
- belongs_to :prefecture
- belongs_to :code

## product_images
|Column|Type|Options|
|------|----|-------|
|image_name|string|null: false|
|product_id|integer| foreign_key: true|

### Association
- belongs_to :product

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture_id|references|null: false, foreign_key: true|
|city|string|null: false|
|street|string|null: false|
|building_name|string||	    
|telehone_number|string|unique: true|
|user_id|references|null: false, foreign_key: true|
#Association        
- belongs_to:user
- belongs_to:prefecture


## credit_cardsテーブル
|Column|Type|Option|
|------|----|------|
|card_number|integer|null:false, unique: true
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
|card_name|string|null: false|
|user_id|references|null: false, foreign_key: true|
### Association 　　　　
- belongs_to:user

## categoryテーブル
|Column|Type|Option|
|------|----|------|						
|Colum	|Type|Options|
|class|integer|null: false|
|parent_id|integer|null: false|
|name|string|null: false|		
								
### Association								
- has_many :products

## brandテーブル
|Column|Type|Option|
|------|----|------|						
|Colum	|Type|Options|	
|name|string|null: false|

### Association
- has_many :products	

## orders テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product

## code テーブル
|Column|Type|Options|
|------|----|-------|
|group_code_id|integer|null: false|
|group_code_name|string|null: false|
|code_id|integer|null: false|
|code_name|string|null: false|

### Association
- belongs_to :product

## prefectures テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :address
- has_many :products




