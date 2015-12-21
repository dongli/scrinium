class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer  :group_id          # 群组ID
      t.integer  :node_id           # 节点ID
      t.integer  :user_id           # 用户ID
      t.string   :title             # 标题
      t.text     :content           # 内容
      t.integer  :views_count       # 浏览计数
      t.integer  :comments_count    # 评论计数
      t.boolean  :sticky            # 置顶
      t.boolean  :essential         # 精华
      t.string   :status            # 状态：public, closed
      t.integer  :position          # 位置（预留字段）
      t.datetime :last_edited_at    # 最后修改时间
      t.datetime :last_commented_at # 最后评论时间
      t.datetime :deleted_at        # 软删除时间
      t.timestamps null: false
    end
    add_index :topics, :user_id
    add_index :topics, :group_id
    add_index :topics, :node_id
  end
end
