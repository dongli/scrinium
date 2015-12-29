class CreateGroupOptions < ActiveRecord::Migration
  def change
    create_table :group_options do |t|
      t.integer :group_id, null: false # 群组ID
      t.string  :front_cover           # 主页封面图片
      t.timestamps null: false
    end
  end
end
