require 'rails_helper'
include ActionView::Helpers::DateHelper

RSpec.feature "Posts", type: :feature do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:post1) { FactoryBot.create(:post, user_id: user1.id) }
  let!(:post2) { FactoryBot.create(:post, user_id: user2.id) }
  
  scenario "投稿一覧ページを閲覧する" do
    visit posts_path
    expect(page).to have_title "写真一覧 | Photo Exhibition"
    expect(page).to have_content user1.name
    expect(page).to have_content user2.name
    expect(page).to have_content post1.title
    expect(page).to have_content post2.title
  end
  
  scenario "投稿の詳細ページを閲覧する" do
    visit post_path(post1.id)
    expect(page).to have_title "#{post1.title} | Photo Exhibition"
    expect(page).to have_content post1.title
    expect(page).to have_content time_ago_in_words(post1.created_at)
    
    within("section.user_info") do
      expect(page).to have_content "撮影者"
    end
  end
  
  scenario "投稿する" do
    sign_in user1
    visit root_path
    
    expect {
      fill_in "写真のタイトルを入力してください", with: "投稿テスト"
      click_on "展示する"
      expect(page).to have_content "展示が完了しました！"
      expect(page).to have_content "投稿テスト"
      expect(page).to have_content "展示を取り下げる"
    }.to change(user1.posts, :count).by(1)
  end
  
  scenario "投稿詳細ページから自身の投稿を削除する" do
    sign_in user2
    visit post_path(user1.id)
    expect(page).to_not have_content "展示を取り下げる"
    sign_out user2
    
    sign_in user1
    visit post_path(user1.id)
    
    expect {
      click_on "展示を取り下げる"
      expect(page.current_path).to eq posts_path
      expect(page).to have_content "展示を取り下げました。"
      expect(page).to_not have_content post1.title
    }.to change(user1.posts, :count).by(-1)
  end
  
  scenario "ホームページから自身の投稿を削除する" do
    user1.follow(user2)
    user2.follow(user1)
    
    sign_in user2
    visit root_path
    
    within("#post-#{post1.id}") do
      expect(page).to_not have_content "展示を取り下げる"
    end
    
    sign_out user2
    
    sign_in user1
    visit root_path
    
    expect {
      within("#post-#{post1.id}") do
        click_on "展示を取り下げる"
      end
      
      expect(page.current_path).to eq root_path
      expect(page).to have_content "展示を取り下げました。"
      expect(page).to_not have_content post1.title
    }.to change(user1.posts, :count).by(-1)
  end
  
  scenario "投稿一覧ページから自身の投稿を削除する" do
    sign_in user2
    visit posts_path
    
    within("#post-#{post1.id}") do
      expect(page).to_not have_content "展示を取り下げる"
      sign_out user2
    end
    
    sign_in user1
    visit posts_path
    
    expect {
      within("#post-#{post1.id}") do
        click_on "展示を取り下げる"
      end
      
      expect(page.current_path).to eq posts_path
      expect(page).to have_content "展示を取り下げました。"
      expect(page).to_not have_content post1.title
    }.to change(user1.posts, :count).by(-1)
  end
end
