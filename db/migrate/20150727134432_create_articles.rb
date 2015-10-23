class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to  :user,      index: true     # 所属用户的ID
      t.string      :title,     null: false     # 标题
      t.text        :content,   default: ''     # 内容
      t.string      :privacy,   null: false     # 隐私度，公开，不公开，讨论组公开
      t.string      :status                     # 状态，草稿 | 完成

      t.timestamps null: false
    end
  end
end
