class GroupArticleAssociation < ActiveRecord::Base
  belongs_to :group
  belongs_to :article
end
