class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :user_id, null: false # 所属用户ID
      t.text    :content              # 经历内容
      t.timestamps null: false
    end
  end
end
