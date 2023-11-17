require 'rails_helper'

RSpec.describe 'When I open user show page', type: :system do
  before :all do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all

    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.')
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Poland.')
    @third_user = User.create(name: 'Alan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Singer from Mexico.')

    @first_user.posts.create(title: 'Post1')
    @first_user.posts.create(title: 'Post2')
    @first_user.posts.create(title: 'Post3')
    @latest_post = @first_user.posts.create(title: 'Post4')
    @second_user.posts.create(title: 'Post1')
    @second_user.posts.create(title: 'Post2')
  end

  it 'shows the user\'s profile picture, username, number of posts, bio, and latest 3 posts' do
    users = [@first_user, @second_user, @third_user]

    users.each do |user|
      visit users_path
      click_link(user.name)
      sleep(1)

      expect(page).to have_css("img[src='#{user.photo}']")
      expect(page).to have_content(user.name)
      expect(page).to have_content("Number of posts: #{user.posts.count}")
      expect(page).to have_content(user.bio)

      user.posts.last(3).each do |post|
        expect(page).to have_content(post.title)
      end
    end
  end

  it 'shows a button that lets me view all of a user\'s posts' do
    visit users_path
    click_link(@first_user.name)
    sleep(1)

    expect(page).to have_link('See all posts', href: user_posts_path(@first_user, page: 1))
  end

  context "When I click a user's post" do
    it "redirects me to that post's show page" do
      visit users_path
      click_link(@first_user.name)
      click_link('Post4')
      sleep(1)

      expect(page).to have_current_path(user_post_path(@first_user, @latest_post))
    end
  end

  context 'When I click to see all posts' do
    it "redirects me to the user's post index page" do
      visit users_path
      click_link(@first_user.name)
      click_link('See all posts')
      sleep(1)

      expect(page).to have_current_path(user_posts_path(@first_user, page: 1))
    end
  end
end
