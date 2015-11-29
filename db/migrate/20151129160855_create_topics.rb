class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.string  :title
      t.text    :content
      t.integer :views_count
      t.integer :comments_count
      t.string  :status
      t.integer :position

      t.timestamps null: false
    end

    add_index :topics, :user_id

  end
end
