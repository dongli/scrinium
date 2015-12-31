class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to  :user,        null: false                    # 用户ID
      t.references  :commentable, null: false, polymorphic: true # 所属类别
      t.text        :content,     null: false                    # 内容
      t.integer     :parent_id                                   # 被回复的回复
      t.integer     :floor,       null: false, default: 0        # 楼层
      t.string      :status                                      # 状态
      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, :parent_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
