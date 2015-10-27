class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string      :name, index: true                           # 地址名称（一个机构可能有多个园区）
      t.references  :addressable, polymorphic: true, index: true # 所属类别
      t.string      :country                                     # 国家
      t.string      :city                                        # 城市
      t.string      :district                                    # 行政区
      t.string      :street                                      # 街道
      t.string      :zip_code                                    # 邮编
      t.string      :status                                      # 状态
      t.integer     :position                                    # 位置（预留字段）

      t.timestamps null: false
    end
  end
end
