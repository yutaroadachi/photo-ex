require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:user3) { FactoryBot.create(:user) }
  
  before do
    sign_in user1
    visit user_path(user2.id)
  end
  
  scenario "ユーザーをフォローする" do
    expect {
      click_on "フォロー"
      expect(page).to have_css ".btnsub"
      expect(page).to_not have_css ".btn-primary"
    }.to change(user1.following, :count).by(1).and change(user2.followers, :count).by(1)
  end
  
  scenario "ユーザーのフォローを解除する" do
    click_on "フォロー"
    
    expect {
      click_on "フォロー解除"
      expect(page).to have_css ".btn-primary"
      expect(page).to_not have_css ".btnsub"
    }.to change(user1.following, :count).by(-1).and change(user2.followers, :count).by(-1)
  end
end
