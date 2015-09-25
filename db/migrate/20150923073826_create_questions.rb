class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :survey, index: true
      t.integer :question_type
      t.string :content
      t.boolean :accept_extra_answer, default: false

      t.timestamps null: false
    end
  end
end
