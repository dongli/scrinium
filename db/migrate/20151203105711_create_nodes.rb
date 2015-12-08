class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :user_id
      t.string :name
      t.integer :group_id
      t.string :status
      t.integer :position

      t.timestamps null: false

    end

    add_index :nodes, :group_id

  end
end
