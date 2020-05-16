class CreatePays < ActiveRecord::Migration[5.2]
  def change
    create_table :pays do |t|
      t.integer :user_id
      t.string :customer_id, null: false
      t.string :card_id, null: false
      t.timestamps
    end
  end
end
