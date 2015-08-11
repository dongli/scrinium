class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true
      t.string  :title,   null: false
      t.text    :content, null: false
      t.boolean :draft,   null: false
      t.integer :privacy, null: false

      t.timestamps null: false
    end
  end
end
