class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id     # 用户的ID
      t.string  :avatar      # 头像
      t.string  :gender      # 性别
      t.string  :affiliation # 所属机构
      t.string  :title       # 职位，或者教授之类的
      t.string  :location    # 地址
      t.string  :country     # 国家
      t.string  :signature   # 签名
      t.text    :bio         # 简介
      t.string  :contact     # 联系方式
      t.timestamps null: false
    end

    add_index :profiles, :user_id

  end
end
