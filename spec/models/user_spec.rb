# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  email                  :string           not null
#  mobile                 :string
#  encrypted_password     :string           not null
#  role                   :string           not null
#  deleted_at             :datetime
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  authentication_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context "create users" do
    it "create a user" do
      user = User.create!(
          name: '董理',
          role: 'admin',
          email: 'dongli@qq.com',
          password: '12345678',
          password_confirmation: '12345678',
          profile_attributes: {
              gender: 'male',
              title: 'freeman'
          }
      )
      expect(user.email).to eq('dongli@qq.com')
      expect(user.profile.gender) != ('male1')

    end
  end
end
