require 'rails_helper'
include ActionView::Helpers::DateHelper

RSpec.feature "Comments", type: :feature do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:user3) { FactoryBot.create(:user) }
  let!(:post1) { FactoryBot.create(:post, user_id: user1.id) }
  let!(:comment1) { FactoryBot.create(:comment, post_id: post1.id, user_id: user2.id) }
  let!(:comment2) { FactoryBot.create(:comment, post_id: post1.id, user_id: user3.id) }
  
  before do
    sign_in user2
    visit post_path(post1.id)
  end
  
  scenario "投稿にコメントする" do
    expect {
      fill_in "写真へのコメントを入力してください", with: "コメントテスト"
      click_on "コメントする"
      expect(page).to have_content "コメントが完了しました！"
      expect(page).to have_content "コメントテスト"
      expect(page).to have_content "コメントを削除する"
    }.to change(post1.comments, :count).by(1)
  end
  
  scenario "投稿のコメントを削除する" do
    expect {
      within("#comment-#{comment1.id}") do
        click_on "コメントを削除する"
      end
      
      expect(page).to have_content "コメントを削除しました。"
      expect(page).to_not have_content comment1.content
    }.to change(post1.comments, :count).by(-1)
  end
  
  scenario "投稿の詳細ページでコメントを閲覧する" do
    expect(page).to have_content comment2.content
    expect(page).to have_content time_ago_in_words(comment2.created_at)
  end
end
