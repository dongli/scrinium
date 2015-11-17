# == Schema Information
#
# Table name: folders
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string
#  description     :string
#  item_count      :integer
#  parent_id       :integer
#  folderable_id   :integer
#  folderable_type :string
#  status          :string
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Folder < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [
    :normal,
    :hidden,
    :trashed
  ], default: :normal, predicates: true

  belongs_to :user
  belongs_to :folderable, polymorphic: true
  has_many :resources, dependent: :destroy
  belongs_to :parent, class_name: 'Folder', foreign_key: 'parent_id'
  has_many :children, class_name: 'Folder', foreign_key: 'parent_id', dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }
end
