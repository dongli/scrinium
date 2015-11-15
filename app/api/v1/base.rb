module V1
  class Base < Grape::API
    version 'v1', using: :path

    mount V1::ApiBase
    mount V1::GroupsAPI
    mount V1::OrganizationsAPI
    mount V1::MailboxAPI
    mount V1::PublishersAPI
    mount V1::UsersAPI
    mount V1::Sessions

    add_swagger_documentation(
        :api_version => "api/v1",
        hide_documentation_path: true,
        hide_format: true
    )

  end
end

