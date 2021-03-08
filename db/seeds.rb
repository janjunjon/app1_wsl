# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

30.times do |n|
	title = "test ${n}"
	name = Faker::Name.name
	year = rand(2000..2020)
	abstract = Faker::Lorem.sentence(wordcount: 100)
	Article.create!(title: title,
					name: name,
					year: year,
					abstract: abstract,
					created_at: Time.zone.now,
					updated_at: Time.zone.now)
end