journals = [
  {
    name: 'Monthly Weather Review',
    abbreviation: 'Mon. Wea. Rev.',
    short_name: 'MWR',
    issued: false
  },
  {
    name: 'Geoscientific Model Development',
    abbreviation: 'Geosci. Model Dev.',
    short_name: 'GMD',
    issued: false
  },
  {
    name: 'Geoscientific Model Development Discussions',
    abbreviation: 'Geosci. Model Dev. Discuss.',
    short_name: 'GMDD',
    issued: false
  }
]

journals.each do |j|
  Journal.create(j)
end
