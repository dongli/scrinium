class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.belongs_to :user,        index: true                     # 收藏人的ID
      t.references :collectable, polymorphic: true, index: true  # 收藏的什么
      t.boolean    :watched,     default: false                  # 是否关注
      t.boolean    :updated,     default: false                  # 是否更新？
      t.integer    :position                                     # 位置（预留字段）

      t.timestamps null: false
    end
  end
end
