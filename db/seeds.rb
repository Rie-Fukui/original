# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do |n|
  User.create!(name: "test#{n}", email: "test#{n}@test.com", password: "pasword")
  2.times do
    Micropost.create(user_id: n, content: "x"*50, title: "damy", word: "test")
  end
end
