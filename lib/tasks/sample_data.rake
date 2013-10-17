namespace :db do
  desc "Fill web service database with sample data"
  task populate: :environment do
    make_users
    make_stickertypes
    make_stickers
    make_locations
    make_relationships
    make_friendships
    #make_messages
  end
end

def make_users
  admin = User.create!(first_name: "Benoit",
                       last_name: "Liabastre",
                       email:     "b.liabastre@gmail.com",
                       password:  "ladeno12",
                       password_confirmation: "ladeno12",
                       adress:    "13 Les Grenadiers",
                       zip_code:  "83310",
                       city:      "Grimaud",
                       country:   "France",
                       phone:     "008613001938293",
                       compteur: 0)
  admin.toggle!(:admin)

  admin = User.create!(first_name: "Frederic",
                       last_name: "Theault",
                       email:    "ftheault@gmail.com",
                       password: "astero",
                       password_confirmation: "astero",
                       compteur: 0)
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Adrien",
                       last_name: "Guffens",
                       email:    "adril.gu@gmail.com",
                       password: "adri24",
                       password_confirmation: "adri24",
                       compteur: 0)
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Denis",
                       last_name: "Anfossi",
                       email:    "anfoss_d@epitech.net",
                       password: "password",
                       password_confirmation: "password",
                       compteur: 0)
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Sylvain",
                       last_name: "Reclus",
                       email:    "reclus_s@epitech.net",
                       password: "password",
                       password_confirmation: "password",
                       compteur: 0)
  admin.toggle!(:admin)

  admin = User.create!(first_name:     "Irfane",
                       last_name: "Goulamabasse",
                       email:    "goulam_a@epitech.net",
                       password: "password",
                       password_confirmation: "password",
                       compteur: 0)
  admin.toggle!(:admin)
  
  admin = User.create!(first_name:     "Yann",
                       last_name: "Koeth",
                       email:    "koeth_y@epitech.net",
                       password: "password",
                       password_confirmation: "password",
                       compteur: 0)
  admin.toggle!(:admin)
  
  30.times do |n|
    first_name  = Faker::Name.first_name
    last_name  = Faker::Name.last_name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(first_name: first_name,
                 last_name: last_name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 compteur: 0)
  end
end

def make_stickertypes
  StickerType.create!(name: "sticker", icon: "icon-user")
  StickerType.create!(name: "iPhone", icon: "icon-user")
  StickerType.create!(name: "Android", icon: "icon-user")
end

def make_stickers
  users = User.all
  5.times do |n|
    users.each { |user|
      name = Faker::Lorem.sentence(2)
      user.stickers.create!(name: name, sticker_type_id: StickerType.first.id, text: Faker::Lorem.sentence(20), color: "#" + "%06x" % (rand * 0xffffff))
    }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  user.stickers.create!(name: "TEST STICKER OFFICIEL",
                        text: 'This is the super ultra hard rocking test sticker that will be used to demonstrate basic concepts of the application.')
  user.stickers.find_by_name("TEST STICKER OFFICIEL").locations.create!(latitude: 39.948437, longitude: 116.341043)
  user.stickers.find_by_name("TEST STICKER OFFICIEL").locations.create!(latitude: 39.487085, longitude: 115.964024)
  user.stickers.find_by_name("TEST STICKER OFFICIEL").locations.create!(latitude: 39.438314, longitude: 116.308033)
  owners = users[2..5]
  owners.each { |owner| user.follow!(owner.id, owner.stickers.first.id) }
end

def make_locations
  stickers = Sticker.all
  stickers.each { |sticker|
    3.times do |n|
      sticker.locations.create!(latitude: (-50 + rand(130)), longitude: (-130 + rand(180)))
    end
  }
end

def make_friendships
  users = User.all
  users.each do |u|
    users.first.add_friend!(u) unless u == users.first
  end
end

def make_messages
  users = User.all
  admin = User.first
  users.each do |u|
    u.send_message!(admin, Faker::Lorem.sentence(12), get_message_suject(u, admin)) unless u == admin
  end
end
