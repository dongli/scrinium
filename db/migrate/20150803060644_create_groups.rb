class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.integer :admin_id,    null: false
      t.integer :privacy,     null: false

      t.timestamps null: false
    end
    Group.create_translation_table!({
      name: :string,
      description: :text
    })
  end
  def down
    drop_table :groups
    Group.drop_tranlation_table!
  end
end
