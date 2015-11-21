class UserSerializer < BaseSerializer

  attributes :id, :name, :email
  has_one :profile


end