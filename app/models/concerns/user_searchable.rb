module UserSearchable
  extend ActiveSupport::Concern
  require 'elasticsearch/model'

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping dynamic: false do
      indexes :name
      indexes :email
    end

    def self.search(query, options)

      @search_definition = {
          query: {}

      }
      if query.present?
        @search_definition[:query] = {
            multi_match: {
                query: query.to_s,
                fields: ['name', 'email'],
                operator: 'or'
            }

        }
      else
        @search_definition[:query] = { match_all: {} }
        # @search_definition[:sort]  = { updated_at: 'desc' }
      end

      __elasticsearch__.search(@search_definition)

    end

    # def as_indexed_json(options={})
    #   self.as_json(
    #       include: { user: {only: [:id, :name, :email]} }
    #   )
    # end
  end
end