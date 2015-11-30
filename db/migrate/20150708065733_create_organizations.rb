class CreateOrganizations < ActiveRecord::Migration
  def up
    create_table :organizations do |t|
      t.string     :logo                                  # 头像
      t.references :admin,  class_name: 'User'            # 机构超级管理员的ID
      t.references :parent, class_name: 'Organization'    # 父机构的ID
      t.string     :website                               # 网址
      t.string     :subdomain                             # 二级域名
      t.string     :status                                # 状态， 新建，上线，下线
      t.integer    :position                              # 位置（预留字段）
      t.timestamps null: false
    end
    Organization.create_translation_table!({
      name: :string,                                      # 关联表中，机构的名称
      short_name: :string,                                # 机构的简称
      description: :text                                  # 描述
    })

    add_index :organizations, :parent_id
    add_index :organizations, :admin_id
    add_index :organizations, :subdomain
  end

  def down
    remove_index :organizations, :parent_id
    remove_index :organizations, :admin_id

    drop_table :organizations
    Organization.drop_tranlation_table!
  end
end
