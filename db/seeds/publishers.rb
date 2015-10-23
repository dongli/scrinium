publishers = [
  {
    publisher_type: 'journal',
    name: 'Monthly Weather Review',
    abbreviation: 'Mon. Wea. Rev.',
    short_name: 'MWR',
    issued: false
  },
  {
    publisher_type: 'journal',
    name: 'Geoscientific Model Development',
    abbreviation: 'Geosci. Model Dev.',
    short_name: 'GMD',
    issued: false
  },
  {
    publisher_type: 'journal',
    name: 'Geoscientific Model Development Discussions',
    abbreviation: 'Geosci. Model Dev. Discuss.',
    short_name: 'GMDD',
    issued: false
  }
]

publishers.each do |publisher|
  Publisher.create publisher
end
