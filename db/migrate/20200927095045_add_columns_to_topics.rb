class AddColumnsToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :name, :string
  end
end
