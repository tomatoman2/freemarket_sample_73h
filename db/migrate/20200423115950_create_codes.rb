class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.integer :group_code_id, null: false
      t.string :group_code_name, null: false
      t.integer :code_id, null: false
      t.string :code_name, null: false
      t.timestamps
    end
  end
end
