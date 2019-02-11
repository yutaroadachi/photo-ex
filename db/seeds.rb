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