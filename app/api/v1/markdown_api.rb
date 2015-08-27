module V1
  class MarkdownAPI < Grape::API
    helpers ApplicationHelper
    desc 'Markdown a given text.'
    params do
      requires :text, type: String, desc: 'Text to be markdowned.'
    end
    post :markdown do
      markdown params[:text]
    end
  end
end
