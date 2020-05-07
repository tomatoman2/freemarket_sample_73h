class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name ,null: false
      t.integer :category_id ,null: false, foreign_key: true
      t.integer :brand_id ,foreign_key: true
      t.string :brand_name
      t.string :size
      t.decimal :price ,null: false
      t.integer :postage_code  ,null: false, foreign_key: true
      t.text :explanation ,null: false
      t.integer :status ,null: false
      t.integer :user_id ,foreign_key: true
      t.integer :prefecture_id ,null: false
      t.integer :delivery_time_code ,null: false
      t.timestamps
    end
  end
end
