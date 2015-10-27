class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :group,                       null: false, index: true # 挂靠的群组
      t.references :user,                        null: false, index: true # 所属的用户
      t.references :postable, polymorphic: true, null: false              # 充当话题的对象
      t.boolean    :sticky,   default: false                              # 是否置顶
      t.string     :status                                                # 状态
      t.integer    :position                                              # 位置（预留字段）

      t.timestamps null: false
    end
  end
end
