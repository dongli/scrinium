class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string  :avatar
      t.string  :gender
      t.string  :title              # 职位
      t.string  :city
      t.string  :country            # 国籍
      t.string  :qq
      t.string  :weibo
      t.string  :wechat
      t.timestamps null: false
    end
  end
end
