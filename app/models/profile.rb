# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  avatar      :string
#  gender      :string
#  affiliation :string
#  title       :string
#  location    :string
#  country     :string
#  signature   :string
#  bio         :text
#  contact     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Profile < ActiveRecord::Base
  extend Enumerize

  enumerize :gender, in: [ :female, :male ], default: :male, predicates: true
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
                       ], predicates: true, default: :freeman

  mount_uploader :avatar, AvatarUploader

  # 使用Jcrop裁剪头像，下面这四个变量是存储裁剪参数。
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :user

  validates :avatar, file_size: { less_than_or_equal_to: 2.megabytes },
            file_content_type: { allow: [ 'image/jpeg', 'image/png' ] }
  validates :gender, :title, presence: true
end
