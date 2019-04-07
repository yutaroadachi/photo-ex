require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }
  
  describe "バリデーションの有効性のテスト" do
    it "content,post_id,user_idがあれば有効な状態となること" do
      expect(comment).to be_valid
    end
    
    it "contentがなければ無効な状態となること" do
      expect(FactoryBot.build(:comment, content: nil)).to be_invalid
    end
    
    it "post_idがなければ無効な状態となること" do
      expect(FactoryBot.build(:comment, post_id: nil)).to be_invalid
    end
    
    it "user_idがなければ無効な状態となること" do
      expect(FactoryBot.build(:comment, user_id: nil)).to be_invalid
    end
  end
end
