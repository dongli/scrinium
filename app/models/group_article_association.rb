# == Schema Information
#
# Table name: group_article_associations
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupArticleAssociation < ActiveRecord::Base
  belongs_to :group
  belongs_to :article
end
