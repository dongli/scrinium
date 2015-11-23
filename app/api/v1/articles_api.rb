module V1
  class ArticlesAPI < Grape::API
    resource :articles do
      desc 'List all articles.'
      get do
        @articles = Article.search(params[:q], options= {}).records
      end
    end
  end
end
