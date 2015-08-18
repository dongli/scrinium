class Group < ActiveRecord::Base
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
end
