class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer  :user_id                # 所属用户的ID
      t.string   :title,     null: false # 标题
      t.text     :content,   default: '' # 内容
      t.integer  :views_count            # 浏览计数
      t.integer  :comments_count         # 评论计数
      t.string   :status                 # 状态：public, draft, trashed
      t.integer  :position               # 位置（预留字段）
      t.datetime :last_edited_at         # 最后修改时间
      t.datetime :last_commented_at      # 最后评论时间
      t.datetime :deleted_at             # 软删除时间
      t.timestamps null: false
    end
    add_index :articles, :user_id
  end
end
