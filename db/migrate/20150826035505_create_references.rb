class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer    :creator_id, index: true
      t.string     :cite_key, index: true
      t.string     :reference_type
      t.string     :authors, array: true, default: []
      t.string     :title
      t.references :publicable, polymorphic: true, index: true
      t.string     :year
      t.string     :volume
      t.string     :issue
      t.string     :pages
      t.string     :doi
      t.text       :abstract
      t.attachment :file

      t.timestamps null: false
    end
  end
end
