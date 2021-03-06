class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.belongs_to  :folder
      t.string      :name,       null: false             # 资源的名称
      t.text        :description                         # 资源的描述
      t.string      :file,       null: false             # 文件
      t.string      :file_size                           # 大小
      t.string      :file_type                           # 类别
      t.string      :file_name                           # 原名称
      t.integer     :user_id,    null: false             # 创建者的ID
      t.references  :resourceable, polymorphic: true     # 所属对象
      t.integer     :share_ids, array: true, default: [] # 记录分享ID
      t.string      :status                              # 状态
      t.string      :uuid                                # 唯一标示符
      t.integer     :position                            # 位置（预留字段）

      t.timestamps null: false
    end

    add_index :resources, :user_id
    add_index :resources, :folder_id
    add_index :resources, :name

  end
end
