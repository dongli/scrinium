class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.belongs_to :user, index: true
      t.references :collectable, polymorphic: true, index: true
      t.boolean :watched, default: false
      t.boolean :updated, default: false

      t.timestamps null: false
    end
  end
end
