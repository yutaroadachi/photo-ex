require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "バリデーションの有効性のテスト" do
    it "name,email,passwordがあれば有効な状態となること" do
      expect(user).to be_valid
    end
    
    it "nameがなければ無効な状態となること" do
      expect(FactoryBot.build(:user, name: nil)).to be_invalid
    end
    
    it "nameが51字以上ならば無効な状態となること" do
      expect(FactoryBot.build(:user, name: "a"*51)).to be_invalid
    end
    
    it "emailがなければ無効な状態となること" do
      expect(FactoryBot.build(:user, email: nil)).to be_invalid
    end
  
    it "重複したemailなら無効な状態となること" do
      FactoryBot.create(:user, email: "example@mail.com")
      expect(FactoryBot.build(:user, email: "example@mail.com")).to be_invalid
    end
    
    it "passwordがなければ無効な状態となること" do
      expect(FactoryBot.build(:user, password: nil)).to be_invalid
    end
  end
end
