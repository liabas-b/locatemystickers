
  admin = User.create!(first_name: "Benoit",
                       last_name: "Liabastre",
                       email:     "b.liabastre@gmail.com",
                       password:  "ladeno12",
                       password_confirmation: "ladeno12",
                       adress:    "13 Les Grenadiers",
                       zip_code:  "83310",
                       city:      "Grimaud",
                       country:   "France",
                       phone:     "008613001938293")
  admin.toggle!(:admin)

  admin = User.create!(first_name: "Frederic",
                       last_name: "Theault",
                       email:    "ftheault@gmail.com",
                       password: "astero",
                       password_confirmation: "astero")
  admin.toggle!(:admin)

  admin = User.create!(first_name: "Hermes",
                       last_name: "Bozec",
                       email:    "hermes.bozec@epitech.eu",
                       password: "azerty",
                       password_confirmation: "azerty")
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Adrien",
                       last_name: "Guffens",
                       email:    "adril.gu@gmail.com",
                       password: "adri24",
                       password_confirmation: "adri24")
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Denis",
                       last_name: "Anfossi",
                       email:    "anfoss_d@epitech.net",
                       password: "password",
                       password_confirmation: "password")
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Sylvain",
                       last_name: "Reclus",
                       email:    "reclus_s@epitech.net",
                       password: "password",
                       password_confirmation: "password")
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Irfane",
                       last_name: "Goulamabasse",
                       email:    "goulam_a@epitech.net",
                       password: "password",
                       password_confirmation: "password")
  admin.toggle!(:admin)
  
  admin = User.create!(first_name:     "Yann",
                       last_name: "Koeth",
                       email:    "koeth_y@epitech.net",
                       password: "password",
                       password_confirmation: "password")
  admin.toggle!(:admin)
  
#   30.times do |n|
#     first_name  = Faker::Name.first_name
#     last_name  = Faker::Name.last_name
#     email = "example-#{n+1}@railstutorial.org"
#     password  = "password"
#     User.create!(first_name: first_name,
#                  last_name: last_name,
#                  email:    email,
#                  password: password,
#                  password_confirmation: password,
#                  compteur: 0)
#   end

  StickerType.create!(name: "sticker", icon: "icon-user")
  StickerType.create!(name: "iPhone", icon: "icon-user")
  StickerType.create!(name: "Android", icon: "icon-user")

#   users = User.all
#   5.times do |n|
#     users.each { |user|
#       name = Faker::Lorem.sentence(2)
#       user.stickers.create!(name: name, sticker_type_id: StickerType.first.id, text: Faker::Lorem.sentence(20), color: "#" + "%06x" % (rand * 0xffffff))
#     }
#   end

#   users = User.all
#   user  = users.first
#   user.stickers.create!(name: "TEST STICKER OFFICIEL",
#                         text: 'This is the super ultra hard rocking test sticker that will be used to demonstrate basic concepts of the application.',
#                         color: '#bd1e39')
#   user.stickers.find_by_name("TEST STICKER OFFICIEL").locations.create!(latitude: 39.948437, longitude: 116.341043)
#   user.stickers.find_by_name("TEST STICKER OFFICIEL").locations.create!(latitude: 39.487085, longitude: 115.964024)
#   user.stickers.find_by_name("TEST STICKER OFFICIEL").locations.create!(latitude: 39.438314, longitude: 116.308033)
#   owners = users[2..5]
#   owners.each { |owner| user.follow!(owner.id, owner.stickers.first.id) }
# ke_locations
#   stickers = Sticker.all
#   stickers.each { |sticker|
#     1.times do |n|
#       sticker.locations.create!(latitude: (-50 + rand(130)), longitude: (-130 + rand(180)))
#     end
#   }

#   users = User.all
#   users.each do |u|
#     users.first.add_friend!(u) unless u == users.first
#   end

#   users = User.all
#   admin = User.first
#   users.each do |u|
#     u.send_message!(admin, Faker::Lorem.sentence(12), get_message_suject(u, admin)) unless u == admin
#   end
User.first.stickers.create!(name: "My professional case",
                                        text: "I can never lose it !",
                                        color: '#bd1e39', tags_as_string: "professional;security")
User.first.stickers.create!(name: "At Epitech",
                                        text: "Just jammin'",
                                        color: '#2E8300', tags_as_string: "school;projects")
User.create!(first_name:     "Jean Charles",
                       last_name: "Delajoie",
                       email:    "delajoie@departout.com",
                       password: "password",
                       password_confirmation: "password")

user.stickers.create!(name: "Employee 1",
                                        text: "Wandering around'",
                                        color: '#DB3000', tags_as_string: "professional;Employee")