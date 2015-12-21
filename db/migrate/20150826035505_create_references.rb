class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.belongs_to :publisher,     index: true              # 出版社，可以是学术期刊杂志，也可以是图书出版社。
      t.integer    :creator_id,    index: true
      t.string     :cite_key,      index: true              # 文献在其它地方被引用时使用的key，比如Dong:2012ab。
      t.string     :reference_type                          # 文献类型，比如分为“文章”，“书籍”，“会议”等等。
      t.string     :authors,       array: true, default: []
      t.string     :editors,       array: true, default: []
      t.string     :school
      t.string     :organization                            # 会议组织或赞助机构。
      t.string     :institution
      t.string     :title
      t.string     :booktitle
      t.string     :year
      t.string     :volume
      t.string     :issue
      t.string     :series
      t.string     :pages
      t.string     :edition
      t.string     :chapter
      t.string     :howpublished
      t.string     :doi
      t.text       :abstract
      t.string     :file
      t.string     :link                                    # 外部链接
      t.string     :status
      t.integer    :position                                # 位置（预留字段）

      t.timestamps null: false
    end
  end
end
