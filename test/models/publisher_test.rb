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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
