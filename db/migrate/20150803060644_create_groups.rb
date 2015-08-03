class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string  :name,        null: false
      t.text    :description, null: false
      t.integer :owner_id,    null: false
      t.integer :privacy,     null: false

      t.timestamps null: false
    end
  end
end
