class CreateOrganizations < ActiveRecord::Migration
  def up
    create_table :organizations do |t|
      t.string     :logo
      t.references :admin,  class_name: 'User'
      t.references :parent, class_name: 'Organization'
      t.string     :website
      t.string     :status
      t.timestamps                                     null: false
    end
    Organization.create_translation_table!({
      name: :string,
      short_name: :string,
      description: :text
    })
  end
  def down
    drop_table :organizations
    Organization.drop_tranlation_table!
  end
end
