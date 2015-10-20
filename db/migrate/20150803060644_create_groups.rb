class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.string     :logo
      t.references :admin,   class_name: 'User'
      t.string     :privacy,                    null: false
      t.string     :status
      t.timestamps                              null: false
    end
    Group.create_translation_table!({
      name: :string,
      short_name: :string,
      description: :text
    })
  end
  def down
    drop_table :groups
    Group.drop_tranlation_table!
  end
end
