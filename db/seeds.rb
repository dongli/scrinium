# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[ 'publishers', 'examples' ].each do |seed|
  load "#{FileUtils.pwd}/db/seeds/#{seed}.rb"
end

Dir.glob("#{FileUtils.pwd}/db/seeds/engine/*.rb") { |seed| load seed }
