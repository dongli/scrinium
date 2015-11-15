require "grape-swagger"
class API < Grape::API
  prefix 'api'
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  error_formatter :json, V1::ErrorFormatter
  rescue_from :all, backtrace: true
  include Grape::Kaminari
  helpers AuthenticateHelper

  mount V1::Base

end
