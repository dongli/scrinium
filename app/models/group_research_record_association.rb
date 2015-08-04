class GroupResearchRecordAssociation < ActiveRecord::Base
  belongs_to :group
  belongs_to :research_record
end
