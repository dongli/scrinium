class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  mount UsersAPI
end