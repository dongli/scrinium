class UserQuotum < ActiveRecord::Base
  acts_as_tenant :user

  belongs_to :user

  before_create :set_defaults

  private

  def set_defaults
    self.max_resources_size = 100 # MB
    self.max_articles_count = 50
    self.max_groups_count = 5
  end
end
