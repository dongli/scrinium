class Group < ActiveRecord::Base
  validates :admin_id, presence: true
  has_attached_file :logo, styles: { medium: '150x150', thumb: '100x100', small: '20x20' }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  has_many :group_user_associations
  has_many :users, through: :group_user_associations
  has_many :group_article_associations
  has_many :articles, through: :group_article_associations
  acts_as_taggable
  acts_as_taggable_on :categories
  translates :name, :description

  enum privacy: [
    :public,
    :private
  ].map { |x| I18n.t("privacy_types.#{x}") }

  def admin
    @admin = User.find(self.admin_id) if not defined? @admin or @admin.id != self.admin_id
    @admin
  end
end
