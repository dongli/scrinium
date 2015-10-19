class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true
      t.string :title, null: false
      t.text :content, default: ''
      t.string :privacy, null: false
      t.string :status

      t.timestamps null: false
    end
  end
end
