require "test_helper"

class LogoutUserTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                        password: "password", admin: false)
  end
  test "should logout user" do
    delete logout_url
    assert_redirected_to root_url
    assert_equal 'Logged out successfully', flash[:notice]
    assert_nil session[:user_id]
  end
end
