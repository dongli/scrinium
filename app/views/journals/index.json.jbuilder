json.array!(@journals) do |journal|
  json.extract! journal, :id, :name, :short_name
  json.url journal_url(journal, format: :json)
end
