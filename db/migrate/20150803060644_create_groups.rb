class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.string     :logo                      # 图标
      t.references :admin, class_name: 'User' # 群组的超级管理员
      t.string     :status                    # 状态：public, private
      t.integer    :members_count, default: 0 # 成员计数
      t.integer    :topics_count, default: 0  # 话题计数
      t.integer    :nodes_count, default: 0   # 节点计数
      t.integer    :position, default: 0      # 位置（预留字段）
      t.datetime   :deleted_at                # 软删除时间
      t.timestamps null: false
    end
    Group.create_translation_table!({
      name: :string,
      short_name: :string,
      description: :text
    })

    add_index :groups, :admin_id
  end

  def down
    drop_table :groups
    Group.drop_tranlation_table!
  end
end
