class AddTopicToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :topic_id, :integer
  end
end
