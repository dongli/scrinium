class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :host, polymorphic: true, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.string :role, default: 'member', null: false
      t.string :expired_at
      t.string :status, default: 'unapproved'

      t.timestamps null: false
    end
  end
end
