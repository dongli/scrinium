class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  error_formatter :json, V1::ErrorFormatter
  rescue_from :all, backtrace: true

  helpers AuthenticateHelper

  before do
    error!("401 Unauthorized, 401") unless authenticated
  end
  mount V1::ApiBase
  # mount V1::UsersAPI
  mount V1::GroupsAPI
  mount V1::OrganizationsAPI
  mount V1::MailboxAPI
  mount V1::PublishersAPI
  mount V1::Users
  mount V1::Sessions
end
