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

class UserSerializer < BaseSerializer
  attributes :id, :name, :email
  has_one :profile
end
