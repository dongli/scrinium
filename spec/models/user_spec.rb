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
