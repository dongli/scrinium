class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.references :commentable, polymorphic: true, index: true
      t.text :content, null: false
      t.integer :parent_id
      t.integer :floor

      t.timestamps null: false
    end
  end
end
