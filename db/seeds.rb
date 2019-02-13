# ユーザー
User.create!(name:  "テストユーザー",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "foobar"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..30]
followers = users[2..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }