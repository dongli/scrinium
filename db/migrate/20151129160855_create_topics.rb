class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer  :group_id,       null: false             # 群组ID
      t.integer  :node_id,        null: false             # 节点ID
      t.integer  :user_id,        null: false             # 用户ID
      t.string   :title,          null: false             # 标题
      t.text     :content,        null: false             # 内容
      t.integer  :views_count,    null: false, default: 0 # 浏览计数
      t.integer  :comments_count, null: false, default: 0 # 评论计数
      t.boolean  :sticky                                  # 置顶
      t.boolean  :elite                                   # 精华
      t.string   :status                                  # 状态：public, closed
      t.integer  :position                                # 位置（预留字段）
      t.datetime :last_edited_at                          # 最后修改时间
      t.datetime :last_commented_at                       # 最后评论时间
      t.datetime :deleted_at                              # 软删除时间
      t.timestamps null: false
    end
    add_index :topics, :user_id
    add_index :topics, :group_id
    add_index :topics, :node_id
  end
end
