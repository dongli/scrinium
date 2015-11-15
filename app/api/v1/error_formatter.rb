module V1
  module ErrorFormatter

    def self.call message, backtrace, options, env
      { status: false, :message => message }.to_json
    end

  end
end