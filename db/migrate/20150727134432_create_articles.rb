class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer    :user_id                       # 所属用户的ID
      t.string     :title,     null: false     # 标题
      t.text       :content,   default: ''     # 内容
      t.string     :privacy,   null: false     # 隐私度：public，private，group_public
      t.integer    :views_count
      t.integer    :comments_count
      t.string     :status                     # 状态：draft，finished
      t.integer    :position                   # 位置（预留字段）

      t.timestamps null: false
    end

    add_index :articles, :user_id

  end
end
