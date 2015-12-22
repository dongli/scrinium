require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '创建用户' do
    it '默认是角色是user' do
      user = User.create!(
        name: '张三',
        email: 'zhangsan@foobar.com',
        password: '123456',
        password_confirmation: '123456'
      )
      expect(User.all.size).to eq(1)
      expect(User.first.name).to eq('张三')
      expect(User.first.role).to eq('user')
    end
  end
end
