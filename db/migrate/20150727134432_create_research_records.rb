class CreateResearchRecords < ActiveRecord::Migration
  def change
    create_table :research_records do |t|
      t.belongs_to :user, index: true
      t.string  :title,     null: false
      t.text    :content,   null: false
      t.boolean :tag_draft, null: false, default: true

      t.timestamps null: false
    end
  end
end
