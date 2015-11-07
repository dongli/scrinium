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
#  editors        :string           default([]), is an Array
#  school         :string
#  organization   :string
#  institution    :string
#  title          :string
#  booktitle      :string
#  year           :string
#  volume         :string
#  issue          :string
#  series         :string
#  pages          :string
#  edition        :string
#  chapter        :string
#  howpublished   :string
#  doi            :string
#  abstract       :text
#  file           :string
#  status         :string
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Reference < ActiveRecord::Base
  extend Enumerize

  # 取自https://en.wikipedia.org/wiki/BibTeX。
  enumerize :reference_type, in: [
    :article,       # An article from a journal.
    :book,          # A book with an explicit publisher.
    :booklet,       # A work that is printed and bound, but without a named publisher or sponsoring institution.
    :inbook,        # A part of a book, usually untitled. May be a chapter (or section, etc.) and/or a range of pages.
    :conference,    # The same as inproceedings.
    :proceedings,   # The proceedings of a conference.
    :incollection,  # A part of a book having its own title.
    :inproceedings, # An article in a conference proceedings.
    :manual,        # Technical documentation.
    :techreport,    # A report published by a school or other institution, usually numbered within a series.
    :mastersthesis,
    :phdthesis,
    :misc,          # For use when nothing else fits.
    :unpublished    # A document having an author and title, but not formally published.
  ]

  mount_uploader :file, ReferenceUploader

  belongs_to :publisher
  has_many :publications, dependent: :destroy
  has_many :users, through: :publications

  validates :title, uniqueness: { cope: :year }
  validates :title, :authors, :year, :pages, :reference_type, :publisher_id, presence: true
  validates :file, file_size: { less_than_or_equal_to: 100.megabytes },
                   file_content_type: { allow: [ 'application/pdf' ] }
end
