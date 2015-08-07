class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  mount UsersAPI
  mount GroupsAPI
  mount ResearchTeamsAPI
  mount OrganizationsAPI
  mount MarkdownAPI
end
