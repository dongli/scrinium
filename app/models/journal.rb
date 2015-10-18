# == Schema Information
#
# Table name: journals
#
#  id           :integer          not null, primary key
#  name         :string
#  abbreviation :string
#  short_name   :string
#  issued       :boolean
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Journal < ActiveRecord::Base
  has_many :references, as: :publicable
end
