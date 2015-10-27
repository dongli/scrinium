class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user,      index: true     # 所属用户的ID
      t.string     :title,     null: false     # 标题
      t.text       :content,   default: ''     # 内容
      t.string     :privacy,   null: false     # 隐私度：public，private，group_public
      t.string     :status                     # 状态：draft，finished
      t.integer    :position                   # 位置（预留字段）

      t.timestamps null: false
    end
  end
end
