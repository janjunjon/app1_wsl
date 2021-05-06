# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

array = ["学士", "修士", "博士"]
Article.create!(title: "九州地方における、梅雨期降水の多い年と少ない年の大気場の違いに関する研究",
				author: "石原淳太郎",
				year: 2020,
				abstract: "梅雨期において、九州地方では梅雨前線に伴う強い降水が度々見られ
				る。加えて、それに伴う被害も甚大であり、梅雨期の降水に関する研究
				は多くなされている。本研究では、2000 年から 2019 年各年の梅雨期間
				内の降水量を平均し、降水量の多い年・少ない年の特徴を定量的に捉え
				た。梅雨期降水量の平年比が高い 5 年を降水量が多い年とし、梅雨期降
				水量の平年比が低い 5 年を降水量が少ない年とした。また、それ以外の
				10 年はその他 10 年とした。降水量が多い年では、九州地方の大気の水
				蒸気量がその他 10 年より多く、九州地方へ輸送される水蒸気量もその
				他 10 年より多いことが分かった。一方で、降水量が少ない年では、九州
				地方とその周辺で大気の水蒸気量がその他 10 年より少なく、九州地方
				へ輸送される水蒸気量もその他 10 年より少ないことが分かった。さら
				に、九州地方における水蒸気収束量は降水量の多い年と少ない年で統計
				的に有意な差が見られたうえで、降水量は水蒸気収束量に大きく依存す
				ることが分かった。海面水温においては、降水量が多い年・少ない年ど
				ちらとも、九州地方の西の海上でその他 10 年よりも海面水温が高い一
				方、東シナ海南部でその他 10 年よりも海面水温が低いことが分かった。
				また、降水量の多い年と少ない年の相対渦度を比較すると、降水量の多
				い年では、九州の北側にある低気圧性の渦がその他 10 年より強く、降
				水量の少ない年では、九州の南側の高気圧性の渦が強いことが分かった。",
				degree: array[0],
				created_at: Time.zone.now,
				updated_at: Time.zone.now,
				romaji_name: "JuntaroISHIHARA"
)

# 30.times do |n|
# 	title = "test research #{n}"
# 	author = Faker::Name.name
# 	year = rand(2000..2020)
# 	abstract = Faker::Lorem.sentence(word_count: 100)
# 	Article.create!(title: title,
# 					author: author,
# 					year: year,
# 					abstract: abstract,
# 					degree: array[rand(0..2)],
# 					created_at: Time.zone.now,
# 					updated_at: Time.zone.now,
# 					romaji_name: author)
# end

# 30.times do |n|
# 	name = "test_user#{n}"
# 	email = "test_user#{n}@example.com"
# 	password = "password"
# 	User.create!(
# 		name: name,
# 		email: email,
# 		password: password,
# 		password_confirmation: password,
# 		created_at: Time.zone.now,
# 		updated_at: Time.zone.now
# 	)
# end

User.create!(
	name: "lagis_test_user",
	email: "lagis@example.com",
	password: "password",
	password_confirmation: "password",
	activated: true,
	created_at: Time.zone.now,
	updated_at: Time.zone.now
)

News.create!(
	title: "APP",
	contents: "リリースしました。",
	info: "news-default",
	created_at: Time.zone.now,
	updated_at: Time.zone.now
)

News.create!(
	title: "other",
	contents: "21年卒業生に試用してもらいました。",
	info: "other",
	created_at: Time.zone.now,
	updated_at: Time.zone.now
)

News.create!(
	title: "Lagis",
	contents: "Lagis卒論インデックスの運用が始まりました。",
	info: "commodity",
	created_at: Time.zone.now,
	updated_at: Time.zone.now
)