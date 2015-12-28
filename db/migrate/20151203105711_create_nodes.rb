class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string  :name                      # 名称
      t.integer :group_id                  # 群组ID
      t.integer :parent_id                 # 父节点ID
      t.integer :topics_count, default: 0  # 话题计数
      t.string  :status                    # 状态：public, private
      t.integer :position                  # 位置（预留字段）
      t.boolean :on_group_page             # 是否在群组主页显示
      t.timestamps null: false
    end
    add_index :nodes, :group_id
  end
end
