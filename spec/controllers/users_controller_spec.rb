require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET index" do
    it "get all users" do
      user = User.create!(
          name: '董理',
          role: 'admin',
          email: 'dongli3@qq.com',
          password: '12345678',
          password_confirmation: '12345678',
          profile_attributes: {
              gender: 'male',
              title: 'freeman'
          }
      )
      get :index
      puts "#{assigns(:users)}"
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index template" do

      @user = User.create!(
          name: '董理',
          role: 'admin',
          email: 'dongli3@qq.com',
          password: '12345678',
          password_confirmation: '12345678',
          profile_attributes: {
              gender: 'male',
              title: 'freeman'
          }
      )
      sign_in :user, @user
      get :index
      expect(response).to render_template("index")
    end
  end
end
