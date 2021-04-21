# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

array = ["学士", "修士", "博士"]
Article.create!(title: "Differences of atmospheric fields between years with heavy rain and little rain over Kyushu region",
				author: "Juntaro ISHIHARA",
				year: 2020,
				abstract: "Heavy rain accompanied by Baiu front is often 
						observed over Kyushu region in Baiu season. 
						In addition, a damage with this phenomenon 
						at the same time is quite serious. Thus, 
						there are many researches about rainfall 
						in Baiu season. In this paper, 
						by using average precipitation of each year from 2000 
						to 2019 we quantitatively captured, 
						each characteristics of years with heavy rain 
						and little rain. Top 5 years are defined as years 
						with heavy rain, by choosing 5 years in the highest 
						order. In contrast, Bottom 5 years are defined 
						as years with little rain, by choosing 5 years 
						in the lowest order. As a result, in years 
						with heavy rain, amounts of water vapor over 
						Kyushu and that carried to Kyushu region are 
						more than normal year. In opposition, amounts 
						of water vapor over Kyushu and surrounding areas, 
						and that carried to Kyushu region are less than 
						normal year in years with little rain. Moreover, 
						there was a statistical difference between years 
						with heavy rain and years with little rain in water 
						vapor flux divergence, and we revealed that 
						precipitation depends on water vapor flux divergence. 
						Besides, sea surface temperature of both years with 
						heavy rain and little rain from east China sea to 
						off Kyushu region was higher than normal year. 
						In contrast to this, sea surface temperature of 
						both years with heavy rain and little rain was 
						lower over south of east China sea. From a view 
						point of relative vorticity, a disturbance over 
						north off Kyushu was stronger in years with heavy 
						rain, and high pressure over south off Kyushu was stronger 
						in years with little rain.",
				degree: array[0])

30.times do |n|
	title = "test research #{n}"
	author = Faker::Name.name
	year = rand(2000..2020)
	abstract = Faker::Lorem.sentence(word_count: 100)
	Article.create!(title: title,
					author: author,
					year: year,
					abstract: abstract,
					degree: array[rand(0..2)],
					created_at: Time.zone.now,
					updated_at: Time.zone.now)
end

30.times do |n|
	name = "test_user#{n}"
	email = "test_user#{n}@example.com"
	password = "password"
	User.create!(
		name: name,
		email: email,
		password: password,
		password_confirmation: password,
		created_at: Time.zone.now,
		updated_at: Time.zone.now
	)
end

Code.create!(
	classification: "Lagis authentication",
	password: "lagis_info",
	password_confirmation: "lagis_info",
	created_at: Time.zone.now,
	updated_at: Time.zone.now
	)