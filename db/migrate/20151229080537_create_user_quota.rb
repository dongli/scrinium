class CreateUserQuota < ActiveRecord::Migration
  def change
    create_table :user_quota do |t|
      t.integer :user_id,            null: false, index: true
      t.float   :max_resources_size
      t.float   :resources_size,     null: false, default: 0
      t.integer :max_articles_count
      t.integer :articles_count,     null: false, default: 0
      t.integer :max_groups_count
      t.integer :groups_count,       null: false, default: 0
      t.timestamps null: false
    end
  end
end
