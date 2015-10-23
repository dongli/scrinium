class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string  :name                   # 期刊名称
      t.string  :abbreviation           # 缩写
      t.string  :short_name             # 简称
      t.boolean :issued                 # 是否发行
      t.string  :status                  # 状态

      t.timestamps null: false
    end
  end
end
