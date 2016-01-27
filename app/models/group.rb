# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  logo          :string
#  admin_id      :integer
#  status        :string
#  members_count :integer
#  topics_count  :integer
#  nodes_count   :integer
#  position      :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Group < ActiveRecord::Base
  include Resourceable

  extend Enumerize
  enumerize :status, in: [ :public, :private ], default: :public, predicates: true

  extend FriendlyId
  friendly_id :slug, use: :slugged

  mount_uploader :logo, ImageUploader

  # 使用Jcrop裁剪头像，下面这四个变量是存储裁剪参数。
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  acts_as_taggable
  acts_as_taggable_on :categories

  translates :name, :short_name, :description

  has_many :memberships, as: :host, dependent: :destroy
  has_many :users, class_name: 'User', through: :memberships
  has_many :topics, dependent: :destroy
  has_many :nodes, dependent: :destroy

  validates :name, :short_name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true, format: { with: /[a-z0-9_]+/ }
  validates :logo, file_size: { less_than_or_equal_to: 2.megabytes },
                   file_content_type: { allow: [ 'image/jpeg', 'image/png' ] }

  after_create :create_default_associated_models

  def admin
    if not defined? @admin or @admin.id != self.admin_id
      @admin = User.find(self.admin_id)
    else
      @admin
    end
  end

  private

  def create_default_associated_models
    # 创建默认节点。
    [:news, :achievements, :chat].each do |node|
      node = Node.create name: I18n.t("node.defaults.#{node}"), group_id: self.id
      self.nodes << node
    end
  end
end
