class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string  :logo
      t.string  :publisher_type, null: false
      t.string  :name,           null: false
      t.string  :abbreviation,   null: false
      t.string  :short_name,     null: false
      t.boolean :issued,         null: false
      t.string  :status,         default: 'unqualified'

      t.timestamps null: false
    end
  end
end
