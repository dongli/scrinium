class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.references :user,        null: false              # 创建文件夹的用户
      t.string     :name,        null: false              # 文件夹的名称
      t.string     :description                           # 文件夹的描述
      t.integer    :items_count, null: false, default: 0  # 条目数量（条目可以是resource，也可以是folder）
      t.references :parent,      class_name: 'Folder'     # 上一级目录
      t.references :folderable,  polymorphic: true        # 可以创建文件夹的对象
      t.integer    :share_ids,   array: true, default: [] # 记录分享ID
      t.string     :status
      t.integer    :position

      t.timestamps null: false
    end

    add_index :folders, :user_id
    add_index :folders, :parent_id
    add_index :folders, [:folderable_id, :folderable_type]

  end
end
