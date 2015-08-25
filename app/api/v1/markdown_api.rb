module V1
  class MarkdownAPI < Grape::API
    desc 'Markdown a given text.'
    params do
      requires :text, type: String, desc: 'Text to be markdowned.'
    end
    post :markdown do
      ApplicationHelper.markdown params[:text]
    end
  end
end
