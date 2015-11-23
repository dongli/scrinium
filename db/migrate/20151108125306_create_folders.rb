class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.references :user                                # 创建文件夹的用户
      t.string     :name                                # 文件夹的名称
      t.string     :description                         # 文件夹的描述
      t.integer    :item_count                          # 条目数量（条目可以是resource，也可以是folder）
      t.references :parent, class_name: 'Folder'        # 上一级目录
      t.references :folderable, polymorphic: true       # 可以创建文件夹的对象
      t.integer    :share_ids, array: true, default: [] # 记录分享ID
      t.string     :status
      t.integer    :position

      t.timestamps null: false
    end
  end
end
