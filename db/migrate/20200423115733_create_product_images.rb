class CreateProductImages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_images do |t|
      t.string :image_name ,null: false
      t.integer :product_id ,foreign_key: true
      t.timestamps
    end
  end
end
