require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "index including pagination" do
    sign_in users(:michael)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end