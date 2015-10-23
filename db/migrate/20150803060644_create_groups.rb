class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.string     :logo                            # 头像
      t.references :admin,     class_name: 'User'   # 讨论组的超级管理员
      t.string     :privacy,   null: false          # 隐私度，公开 ，还是隐藏，那么这两种会导致何种不同的行为？
      t.string     :status                          # 状态？
      t.timestamps             null: false
    end
    Group.create_translation_table!({
      name: :string,
      short_name: :string,
      description: :text
    })
  end
  def down
    drop_table :groups
    Group.drop_tranlation_table!
  end
end
