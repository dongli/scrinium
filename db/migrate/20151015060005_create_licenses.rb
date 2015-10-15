class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.belongs_to :organization, index: true, null: false
      t.string :engine_name, index: true, null: false
      t.string :expired_at, null: false
      t.integer :max_num_seats, default: 5

      t.timestamps null: false
    end
  end
end
