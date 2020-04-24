class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user_id ,foreign_key: true
      t.references :product_id ,foreign_key: true
      t.string :message
      t.timestamps
    end
  end
end
