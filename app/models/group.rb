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

  mount_uploader :logo, ImageUploader

  # 使用Jcrop裁剪头像，下面这四个变量是存储裁剪参数。
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  # acts_as_taggable
  # acts_as_taggable_on :categories

  translates :name, :short_name, :description

  has_many :memberships, as: :host, dependent: :destroy
  has_many :users, through: :memberships, class_name: 'User'
  # has_many :posts, dependent: :destroy
  belongs_to :admin, class_name: 'User', foreign_key: :admin_id
  has_many :topics, dependent: :destroy
  has_many :nodes, dependent: :destroy

  validates :name, :short_name, presence: true
  validates :logo, file_size: { less_than_or_equal_to: 2.megabytes },
                   file_content_type: { allow: [ 'image/jpeg', 'image/png' ] }
  after_create :create_admin_membership

  def create_admin_membership
    Membership.create(host_type: 'Group', host_id: self.id, role: "admin", status: "approved", user_id: self.admin_id)
    %w(新闻动态 科研成果 精华文章).each_with_index do |name, index|
      Node.create(name: name, group_id: self.id, status: :public, position: index, on_group_page: true)
    end
  end



  # def has_post? postable
  #   not self.posts.select { |x| x.postable_id == postable.id and x.postable_type == postable.class.to_s }.empty?
  # end
end
