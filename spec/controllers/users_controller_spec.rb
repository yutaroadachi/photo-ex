require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  
  describe "#index" do
    before { get :index }
    
    it "正常にレスポンスを返すこと" do
      expect(response).to be_successful
    end
    
    it "@usersが読み込まれていること" do
      expect(assigns(:users)).to match_array user
    end
    
    it "index.html.erbが読み込まれていること" do
      expect(response).to render_template :index
    end
  end
  
  describe "#show" do
    before { get :show, params: { id: user.id } }
    
    it "正常にレスポンスを返すこと" do
      expect(response).to be_successful
    end
    
    it "@userが読み込まれていること" do
      expect(assigns(:user)).to eq user
    end
    
    it "@postsが読み込まれていること" do
      expect(assigns(:posts)).to match_array post
    end
    
    it "show.html.erbが読み込まれていること" do
      expect(response).to render_template :show
    end
  end
end
