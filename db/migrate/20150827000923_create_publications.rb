class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.belongs_to  :user,       index: true, null: false # 创建用户
      t.belongs_to  :reference,  index: true, null: false # 实际文献
      t.string      :matched_author                       # 匹配的作者
      t.string      :status                               # 状态
      t.integer     :position                             # 位置（预留字段）
      t.timestamps null: false
    end
  end
end
