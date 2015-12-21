class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer    :user_id                        # 收藏人的ID
      t.references :collectable, polymorphic: true # 收藏的什么
      t.string     :status                         # 状态：changed, unchanged
      t.integer    :position                       # 位置（预留字段）
      t.timestamps null: false
    end

    add_index :collections, :user_id
    add_index :collections, [:collectable_id, :collectable_type]

  end
end
