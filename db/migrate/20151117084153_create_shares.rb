class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :host,      polymorphic: true, null: false, index: true # 挂靠的对象（如群组、用户）
      t.references :user,                         null: false, index: true # 所属的用户
      t.references :shareable, polymorphic: true, null: false              # 被分享的对象
      t.belongs_to :folder                                                 # 被链接到的文件夹
      t.string     :description                                            # 描述
      t.string     :expired_at                                             # 过期时间
      t.string     :status                                                 # 状态
      t.integer    :position                                               # 位置（预留字段）

      t.timestamps null: false
    end
  end
end
