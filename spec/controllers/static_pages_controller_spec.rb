require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.build(:post, title: nil, user_id: user.id) }
  
  describe "#home" do
    context "ログインしている場合" do
      before do
        sign_in user
        get :home
      end
      
      it "正常にレスポンスを返すこと" do
        expect(response).to be_successful
      end
      
      it "@postが読み込まれていること" do
        expect(assigns(:post).attributes).to eq post.attributes
      end
      
      it "home.html.erbが読み込まれていること" do
        expect(response).to render_template :home
      end
    end
    
    context "ログインしていない場合" do
      before { get :home }
    
      it "正常にレスポンスを返すこと" do
        expect(response).to be_successful
      end
    
      it "home.html.erbが読み込まれていること" do
        expect(response).to render_template :home
      end
    end
  end
end
