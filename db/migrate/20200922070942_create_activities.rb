class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :post_id
      t.string :user_id
      t.integer :field

      t.timestamps
    end
    add_index :activities, :post_id
    add_index :activities, :user_id
  end
end
