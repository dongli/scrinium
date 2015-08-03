class CreateGroupUserAssociations < ActiveRecord::Migration
  def change
    create_table :group_user_associations do |t|
      t.belongs_to :group, index: true
      t.belongs_to :user,  index: true
      t.timestamps null: false
    end
  end
end
