class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.belongs_to  :folder
      t.string      :name,                            index: true # 资源的名称
      t.text        :description                                  # 资源的描述
      t.string      :file                                         # 文件
      t.string      :file_size                                    # 大小
      t.string      :file_type                                    # 类别
      t.string      :file_name                                    # 原名称
      t.integer     :user_id                                      # 创建者的ID
      t.references  :resourceable, polymorphic: true, index: true # 所属对象
      t.string      :status                                       # 状态
      t.string      :uuid                                         # 唯一标示符
      t.integer     :position                                     # 位置（预留字段）

      t.timestamps null: false
    end
  end
end
