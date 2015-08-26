module V1
  class JournalsAPI < Grape::API
    resource :journals do
      desc 'List all journal abbreviations.'
      get :abbreviations do
        Journal.all.map { |j| [ j.id, j.abbreviation ] }
      end

      desc 'Check if the journal is issued.'
      params do
        requires :journal_id, type: Integer, desc: 'Journal ID.'
      end
      post :issued do
        Journal.find(params[:journal_id]).issued
      end
    end
  end
end
