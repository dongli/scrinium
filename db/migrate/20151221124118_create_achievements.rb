class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :user_id  # 用户ID
      t.string  :title    # 名称
      t.text    :content  # 内容
      t.string  :status   # 状态：online, offline
      t.integer :position # 位置（预留字段）
      t.timestamps null: false
    end
  end
end
