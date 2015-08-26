class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string  :name
      t.string  :abbreviation
      t.string  :short_name
      t.boolean :issued

      t.timestamps null: false
    end
  end
end
