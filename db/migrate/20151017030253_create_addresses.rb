class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string      :name, index: true    # 地址名称？
      t.references  :addressable, polymorphic: true, index: true # 所属类别
      t.integer     :order    # 顺序
      t.string      :country  # 国家
      t.string      :city     # 城市
      t.string      :district # 行政区
      t.string      :street   # 街道
      t.string      :zip_code # 邮编
      t.string      :status   # 状态

      t.timestamps null: false
    end
  end
end
