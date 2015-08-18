class CreateGroupArticleAssociations < ActiveRecord::Migration
  def change
    create_table :group_article_associations do |t|
      t.belongs_to :group,   index: true
      t.belongs_to :article, index: true
      t.timestamps null: false
    end
  end
end
