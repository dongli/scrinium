class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name, index: true
      t.references :addressable, polymorphic: true, index: true
      t.integer :order
      t.string :country
      t.string :city
      t.string :district
      t.string :street
      t.string :zip_code
      t.string :status

      t.timestamps null: false
    end
  end
end
