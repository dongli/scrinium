class UserSerializer < BaseSerializer

  attributes :id, :name, :email, :liked
  has_one :profile

  def liked
    'like' if 1 == 2
  end
end