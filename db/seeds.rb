# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#INSTRUMENTS
%w(Piano Guitar Drums Violin Trumpet Kazoo Harp).each do |instrument_name|
  Instrument.create(name: instrument_name)
end

#GENRES
%w(Jazz Rock Classical Country Hiphop).each do |genre_name|
  Genre.create(name: genre_name)
end

#FACILITIES
# Instrument, brand, model
facility_list = [
["Piano", "Yamaha", "C3"],
["Piano", "Beckstein", "CFX Concert"],
["Amp", "Roland", "Cube Street"],
["Drums", "Pearl", "EXX 22"],
["Drums", "Pearl", "ePro EXX Fusion"]
]

facility_list.each do |instrument, brand, model|
  Facility.create(instrument: instrument, brand: brand, model: model)
end

#ROOMS
#name, address, capacty
#NOTE, STILL NEED TO ASSIGN FACILITIES TO ROOM
room_list = [
["Room 1", "Seed Music UK Headquarters, London", 5],
["Room 2", "Seed Music France headquarters, Paris", 25],
["Room 3", "Royal Albert Hall, Kensington Gore, Kensington, London, SW7 2AP", 2000]
]

room_list.each do |name, address, capacity|
  Room.create(name: name, address: address, capacity: capacity)
end

#WHITELIST
#email_or_domain
whitelisted_email_list = [
["gmail.com"],
["hotmail.com"],
["mike@seedmusic.co.uk"]]

whitelisted_email_list.each do |email_or_domain|
  Whitelisted_email.create(email_or_domain: email_or_domain)
end