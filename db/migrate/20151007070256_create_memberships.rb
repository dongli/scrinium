class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.text       :description
      t.belongs_to :host,           polymorphic: true, index: true, null: false # host可能是organization或group。
      t.belongs_to :user,                              index: true, null: false
      t.string     :role,           default: 'member'
      t.datetime   :expired_at                                                  # 可以设置membership的过期时间。
      t.string     :join_type                                                   # 加入类型：主动加入（self）、被动加入（added）、被邀请加入（invited）
      t.text       :rejected_reason
      t.datetime   :rejected_at
      t.datetime   :joined_at                                                   # 加入时间（如主动加入则是被批准时间，如被动加入则是创建时间，如被邀请加入则是接受时间）
      t.integer    :last_user_id                                                # 最后一个修改用户的id
      t.string     :status,         default: 'unapproved'

      t.timestamps null: false
    end
  end
end
