require 'doorkeeper/grape/helpers'

class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json

  helpers Doorkeeper::Grape::Helpers

  mount V1::UsersAPI
  mount V1::GroupsAPI
  mount V1::OrganizationsAPI
  mount V1::MailboxAPI
  mount V1::PublishersAPI
end
