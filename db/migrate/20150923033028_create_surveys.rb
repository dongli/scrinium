class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :preface
      t.attachment :cover_image

      t.timestamps null: false
    end
  end
end
