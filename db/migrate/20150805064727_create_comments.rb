class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to  :user,        index: true                       # 用户ID
      t.references  :commentable, polymorphic: true, index: true    # 所属类别
      t.text        :content,     null: false                       # 内容
      t.integer     :parent_id                                      # 上一楼
      t.integer     :floor                                          # 楼数
      t.string      :status                                         # 状态

      t.timestamps null: false
    end
  end
end
