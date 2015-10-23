class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :publicable,     polymorphic: true, index: true         #  ？
      t.integer    :creator_id,                       index: true          # 创建者，为什么不用user_id?
      t.string     :cite_key,                         index: true          # 文献在其它地方被引用时使用的key，比如Dong:2012ab。
      t.string     :reference_type                                         # 文献类型，比如分为“文章”，“书籍”，“会议”等等。
      t.string     :authors,         array: true, default: []              # 文件的作者，多个
      t.string     :title                 # 标题
      t.string     :year                  # 年份
      t.string     :volume                # 卷
      t.string     :issue                 # 事务
      t.string     :pages                 # 页数
      t.string     :doi                   # 数字对象标识
      t.text       :abstract              # 摘要
      t.string     :file                  # 附件？
      t.string     :status                # 状态

      t.timestamps null: false
    end
  end
end
