class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.belongs_to  :user,       index: true    # 创建出版社的user_id
      t.belongs_to  :reference,  index: true    # 引用？
      t.string      :matched_author             # 匹配的作者
      t.string      :status                     # 作者
      t.integer    :position                    # 位置（预留字段）
      t.timestamps null: false
    end
  end
end
