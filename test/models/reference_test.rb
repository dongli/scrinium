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

require 'test_helper'

class ReferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
