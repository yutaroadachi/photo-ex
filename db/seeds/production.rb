# ユーザー
User.create!(name:  "テストユーザー",
             email: "example@mail.com",
             password:              "password",
             password_confirmation: "password")

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@mail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[2..50]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
