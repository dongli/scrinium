class CreateUserOptions < ActiveRecord::Migration
  def change
    create_table :user_options do |t|
      t.integer :user_id    # 所属用户ID
      t.string :front_cover # 主页封面图片
      t.timestamps null: false
    end
  end
end
