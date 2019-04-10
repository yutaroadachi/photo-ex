require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:post1) { FactoryBot.create(:post, user_id: user1.id) }
  
  before do
    sign_in user2
    visit post_path(post1.id)
  end

  scenario "投稿をいいねする" do
    expect(page).to have_content post1.likes.count
    
    expect {
      click_button ""
      expect(page).to have_css ".glyphicon-heart"
      expect(page).to_not have_css ".glyphicon-heart-empty"
    }.to change(post1.likes, :count).by(1)
  end
  
  scenario "投稿のいいねを取消す" do
    click_button ""
    expect(page).to have_content post1.likes.count
    
    expect {
      click_button ""
      expect(page).to have_css ".glyphicon-heart-empty"
      expect(page).to_not have_css ".glyphicon-heart"
    }.to change(post1.likes, :count).by(-1)
  end
end
