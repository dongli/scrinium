class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, index: true
      t.text :description
      t.attachment :file
      t.integer :user_id
      t.integer :resource_type
      t.references :resourceable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
