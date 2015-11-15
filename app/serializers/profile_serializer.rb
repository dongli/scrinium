class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :gender, :title, :city, :qq

end
