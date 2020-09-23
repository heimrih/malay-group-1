User.create!(name: "Example User",
            email: "example@gamercommunity.com",
            password: "hahaha",
            password_confirmation: "hahaha",
            admin: true,
            activated: true,
            activated_at: Time.zone.now,
            last_sign_in_at: Time.zone.now)

20.times do |n|
  name = Faker::Name.name
  email = "user_1#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now,
              last_sign_in_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
3.times do |n|
  title = "Post #{n+1}"
  body = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(title: title, body: body) }
end


# create post

users = User.all
users.each do |user|
  user.posts.create!(
    title: "This post of #{user.name}user",
    body: "body of post #{user.id}"
  )
end

# create activity
post_ids = Post.pluck :id
users.each do |user|
  user.activities.create!(
    post_id: post_ids.sample,
    field: rand(0..2)
  )
end

