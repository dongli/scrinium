# == Schema Information
#
# Table name: references
#
#  id                :integer          not null, primary key
#  creator_id        :integer
#  cite_key          :string
#  reference_type    :string
#  authors           :string           default([]), is an Array
#  title             :string
#  publicable_id     :integer
#  publicable_type   :string
#  year              :string
#  volume            :string
#  issue             :string
#  pages             :string
#  doi               :string
#  abstract          :text
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Reference < ActiveRecord::Base
  extend Enumerize

  validates_uniqueness_of :title, scope: :year
  validates :title, :authors, :year, :pages, presence: true
  belongs_to :publicable, polymorphic: true
  has_attached_file :file
  validates_attachment_content_type :file, content_type: ['application/pdf']
  has_many :publications, dependent: :destroy
  has_many :users, through: :publications

  validates_presence_of :reference_type

  enumerize :reference_type, in: [
    :article,
    :book
  ]
end
