class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false, default: ''
      t.string :short_name, null: false, default: ''

      t.timestamps null: false
    end
  end
end
