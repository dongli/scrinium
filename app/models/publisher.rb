# == Schema Information
#
# Table name: publishers
#
#  id             :integer          not null, primary key
#  logo           :string
#  publisher_type :string           not null
#  name           :string           not null
#  abbreviation   :string           not null
#  short_name     :string           not null
#  issued         :boolean          not null
#  status         :string           default("unqualified")
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Publisher < ActiveRecord::Base
  extend Enumerize

  enumerize :publisher_type, in: [
    :journal
  ]

  enumerize :status, in: [
    :unqualified,
    :qualified
  ]

  has_many :references, dependent: :destroy

  validates :name, :abbreviation, :short_name, presence: true
end
