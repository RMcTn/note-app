# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Entry.destroy_all
User.destroy_all
user = User.new(email: 'a@a.com', password: 'password', password_confirmation: 'password')
user.skip_confirmation!
user.save!

10.times do |i|
 entry = Entry.create(title: "Entry #{i + 1}", user_id: user.id, created_at: Time.now - i.days, content: "Some <b>TEXT HERE</b> just for testing")
end
