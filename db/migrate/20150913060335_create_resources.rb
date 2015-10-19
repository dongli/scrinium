class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, index: true
      t.text :description
      t.string :file
      t.string :file_size
      t.string :file_type
      t.string :file_name
      t.integer :user_id
      t.references :resourceable, polymorphic: true, index: true
      t.string :status
      t.string :uuid

      t.timestamps null: false
    end
  end
end
