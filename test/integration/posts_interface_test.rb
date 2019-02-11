require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:michael)
  end

  test "post interface" do
    sign_in @user
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "This post really ties the room together"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { title: title } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match title, response.body
    # # 投稿を削除する
    assert_select 'a', text: '展示を取り下げる'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end