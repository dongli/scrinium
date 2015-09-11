class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true
      t.string  :title,   null: false
      t.text    :content, default: ''
      t.boolean :draft,   default: false
      t.integer :privacy, default: 0

      t.timestamps null: false
    end
  end
end
