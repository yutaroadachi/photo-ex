require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }
  
  describe "バリデーションの有効性のテスト" do
    it "title,user_idがあれば有効な状態となること" do
      expect(post).to be_valid
    end
    
    it "titleがなければ無効な状態となること" do
      expect(FactoryBot.build(:post, title: nil)).to be_invalid
    end
    
    it "title,user_idがあれば有効な状態となること" do
      expect(FactoryBot.build(:post, user_id: nil)).to be_invalid
    end
  end
end
