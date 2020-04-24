class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :class, null:false
      t.integer :parent_id
      t.string :name, null:false
      t.timestamps
    end
  end
end
