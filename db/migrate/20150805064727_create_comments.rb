class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to  :user                              # 用户ID
      t.references  :commentable, polymorphic: true    # 所属类别
      t.text        :content,     null: false          # 内容
      t.integer     :parent_id                         # 上一楼
      t.integer     :floor                             # 楼数
      t.string      :status                            # 状态

      t.timestamps null: false
    end

    add_index :comments, :user_id
    add_index :comments, :parent_id
    add_index :comments, [:commentable_id, :commentable_type]

  end
end
