class CreateOrganizationships < ActiveRecord::Migration
  def change
    create_table :organizationships do |t|
      t.integer :organization_id
      t.integer :suborganization_id

      t.timestamps null: false
    end
  end
end
