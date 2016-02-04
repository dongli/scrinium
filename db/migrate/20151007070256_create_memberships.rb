class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.text       :description
      t.belongs_to :host, polymorphic: true, null: false # host可能是group或？？。
      t.integer    :user_id,                 null: false # 加入到机构或者 讨论组人的ID
      t.string     :role                                 # 加入到讨论组中的角色，admin,admin, :assist_admin, :member
      t.datetime   :expired_at                           # 可以设置membership的过期时间
      t.string     :join_type                            # 加入类型：主动加入（self）、被动加入（added）、被邀请加入（invited）
      t.text       :rejected_reason                      # 拒绝的理由
      t.datetime   :rejected_at                          # 拒绝的时间
      t.datetime   :joined_at                            # 加入时间（如主动加入则是被批准时间，如被动加入则是创建时间，如被邀请加入则是接受时间）
      t.integer    :last_user_id                         # 最后一个修改用户的id
      t.string     :status                               # 状态
      t.timestamps null: false
    end

    add_index :memberships, :user_id
    add_index :memberships, :last_user_id
    add_index :memberships, [:host_id, :host_type]

  end
end
