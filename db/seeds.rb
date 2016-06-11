# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Grade.exists?(name: "Khối 10")
	Grade.create(name: "Khối 10")
end

unless Grade.exists?(name: "Khối 11")
	Grade.create(name: "Khối 11")
end

unless Grade.exists?(name: "Khối 12")
	Grade.create(name: "Khối 12")
end