require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:user3) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user_id: user1.id) }
  
  before do
    user1.follow(user2)
    user2.follow(user1)
  end
  
  scenario "ユーザー一覧ページを閲覧する" do
    visit users_path
    expect(page).to have_title "写真家一覧 | Photo Exhibition"
    expect(page).to have_content user1.name
    expect(page).to have_content user2.name
    expect(page).to have_content user3.name
  end
  
  scenario "ユーザーの詳細ページを閲覧する" do
    visit users_path
    click_on user1.name
    expect(page).to have_title "#{user1.name} | Photo Exhibition"
    expect(page).to have_content user1.name
    expect(page).to_not have_content user2.name
    expect(page).to have_content post.title

    within("div.col-md-8 h3") do
      expect(page).to have_content user1.posts.count
    end
    
    within("#following") do
      expect(page).to have_content user1.following.count
    end
  
    within("#followers") do
      expect(page).to have_content user1.followers.count
    end
  end
  
  scenario "フォロー中のユーザー一覧ページを閲覧する" do
    visit user_path(user1.id)
    click_on "フォロー"
    expect(page).to have_title "フォロー中 | Photo Exhibition"
    expect(page).to have_content user2.name
    expect(page).to_not have_content user3.name
  end
  
  scenario "フォロワー一覧ページを閲覧する" do
    visit user_path(user1.id)
    click_on "フォロワー"
    expect(page).to have_title "フォロワー | Photo Exhibition"
    expect(page).to have_content user2.name
    expect(page).to_not have_content user3.name
  end
end
