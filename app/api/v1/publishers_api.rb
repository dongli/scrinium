module V1
  class PublishersAPI < Grape::API
    resource :publishers do
      desc 'List all publisher abbreviations.'
      get :abbreviations do
        Publisher.all.map { |j| [ j.id, j.abbreviation ] }
      end

      desc 'Check if the publisher is issued.'
      params do
        requires :publisher_id, type: Integer, desc: 'Publisher ID.'
      end
      post :issued do
        Publisher.find(params[:publisher_id]).issued
      end
    end
  end
end
