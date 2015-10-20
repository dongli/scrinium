# == Schema Information
#
# Table name: references
#
#  id             :integer          not null, primary key
#  publisher_id   :integer
#  creator_id     :integer
#  cite_key       :string
#  reference_type :string
#  authors        :string           default([]), is an Array
#  title          :string
#  year           :string
#  volume         :string
#  issue          :string
#  pages          :string
#  doi            :string
#  abstract       :text
#  file           :string
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Reference < ActiveRecord::Base
  extend Enumerize

  enumerize :reference_type, in: [
    :article,
    :book
  ]

  mount_uploader :file, ReferenceUploader

  belongs_to :publisher
  has_many :publications, dependent: :destroy
  has_many :users, through: :publications

  validates_uniqueness_of :title, scope: :year
  validates_presence_of :title, :authors, :year, :pages,
                        :reference_type, :publisher_id
  validates :file, file_size: { less_than_or_equal_to: 100.megabytes },
                   file_content_type: { allow: [ 'application/pdf' ] }
end
