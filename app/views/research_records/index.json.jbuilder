json.array!(@research_records) do |research_record|
  json.extract! research_record, :id
  json.url research_record_url(research_record, format: :json)
end
