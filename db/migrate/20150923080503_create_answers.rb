class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question, index: true
      t.belongs_to :feedback, index: true
      t.string :content

      t.timestamps null: false
    end
  end
end
