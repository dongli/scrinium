class CreateResearchTeams < ActiveRecord::Migration
  def up
    create_table :research_teams do |t|
      t.belongs_to :organization, index: true
      t.timestamps null: false
    end
    ResearchTeam.create_translation_table!({
      name: :string,
      short_name: :string,
      description: :text
    })
  end
  def down
    drop_table :research_teams
    ResearchTeam.drop_tranlation_table!
  end
end
