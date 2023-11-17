require 'rails_helper'

RSpec.describe 'When I open user index page', type: :system do
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

    @first_user.posts.create(title: 'Title')
    @first_user.posts.create(title: 'Title')
    @second_user.posts.create(title: 'Title')
  end

  it 'should display 3 users' do
    visit users_path
    expect(page.all('ul#users_container li').size).to eq(3)
  end

  it 'shows the username of all users' do
    visit users_path
    [@first_user, @second_user, @third_user].each do |user|
      expect(page).to have_text(user.name)
    end
  end

  it 'shows the profile picture for each user' do
    visit users_path
    [@first_user, @second_user, @third_user].each do |user|
      expect(page).to have_css("img[src='#{user.photo}']")
    end
  end

  it 'shows the number of posts each user has written' do
    visit users_path
    expect(page).to have_content('Number of posts: 2', count: 1)
    expect(page).to have_content('Number of posts: 1', count: 1)
    expect(page).to have_content('Number of posts: 0', count: 1)
  end

  context 'When I click on a user' do
    it 'redirects to the user\'s show page' do
      users = [@first_user, @second_user, @third_user]
      users.each do |user|
        visit users_path
        click_link(user.name)
        expect(page).to have_current_path(user_path(user))
      end
    end
  end
end
