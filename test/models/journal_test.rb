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

require 'test_helper'

class JournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
