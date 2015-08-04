class CreateGroupResearchRecordAssociations < ActiveRecord::Migration
  def change
    create_table :group_research_record_associations do |t|
      t.belongs_to :group,           index: true
      t.belongs_to :research_record, index: true
      t.timestamps null: false
    end
  end
end
