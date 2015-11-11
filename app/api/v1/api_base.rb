module V1
  class ApiBase < Grape::API
    include Grape::Kaminari
    Grape::Middleware::Error.send :include, ::RespondHelper

    def self.inherited(subclass)
      super
      subclass.class_eval do
        helpers RespondHelper

        before do
          Rails.logger.debug "===> params is: #{params.inspect}\n===> headers is: #{headers.inspect}"
        end


        # rescue_from ApiError::Unauthorized do |error|
        #   code = ApiError.get_code(error)
        #   generate_error_response(error, code)
        # end

        # rescue_from :all do |error|
        #   if error.is_a? ApiError::Base
        #     # code = ApiError.get_code(error)
        #     generate_error_response(error, code)
        #   else
        #     generate_error_response(error, 500)
        #   end
        # end
      end
    end

  end
end
