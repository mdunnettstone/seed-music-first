# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w(harp piano guitar drums violin trumpet kazoo).each do |instrument_name|
  Instrument.create(name: instrument_name)
end

%w(jazz rock classical country hiphop).each do |genre_name|
  Genre.create(name: genre_name)
end
