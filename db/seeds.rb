# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

first_user = User.create(name: 'Mumbere', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Hunter.')
second_user = User.create(name: 'Masika', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer.')
third_user = User.create(name: 'Kabugho', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Driver.')
fourth_user = User.create(name: 'Biira', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Cleaner.')

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'Call me masiks', text: 'kindly view my second post ')
third_post = Post.create(author: first_user, title: 'I am a doctor', text: 'Know more about me')
fourth_post = Post.create(author: first_user, title: 'I am from Uganda', text: 'Descover more about Uganda')
fivth_post = Post.create(author: second_user, title: 'I am a pastor', text: 'Hello there people')

Comment.create(post: first_post, user: second_user, text: 'Nice to see you!')
Comment.create(post: first_post, user: second_user, text: 'You look great!')
Comment.create(post: first_post, user: second_user, text: "Thank you!")
Comment.create(post: first_post, user: third_user, text: 'Meet me in the next few hours')
Comment.create(post: first_post, user: third_user, text: 'Keep the light burning')
Comment.create(post: first_post, user: third_user, text: 'We meet there!')