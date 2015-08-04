class CreateResearchRecords < ActiveRecord::Migration
  def change
    create_table :research_records do |t|
      t.belongs_to :user, index: true
      t.string  :title,   null: false
      t.text    :content, null: false
      t.boolean :draft,   null: false
      t.integer :privacy, null: false
      t.string  :tags,    array: true

      t.timestamps null: false
    end
  end
end
