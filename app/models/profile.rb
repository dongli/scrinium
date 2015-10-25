# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  avatar     :string
#  gender     :string
#  title      :string
#  city       :string
#  country    :string
#  qq         :string
#  weibo      :string
#  wechat     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ActiveRecord::Base
  extend Enumerize

  enumerize :gender, in: [ :female, :male ], predicates: true
  enumerize :title, in: [
                         :academician,
                         :researcher,
                         :associate_researcher,
                         :assistant_researcher,
                         :professor,
                         :associate_professor,
                         :assistant_professor,
                         :postdoctoral_researcher,
                         :postgraduate,
                         :undergraduate,
                         :freeman
                       ], predicates: true

  mount_uploader :avatar, ImageUploader

  belongs_to :user

  validates :avatar, file_size: { less_than_or_equal_to: 2.megabytes },
            file_content_type: { allow: [ 'image/jpeg', 'image/png' ] }
  validates :gender, :title, presence: true
end
