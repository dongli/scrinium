class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.belongs_to :user, index: true
      t.belongs_to :reference, index: true
      t.string :matched_author
      t.timestamps null: false
    end
  end
end
