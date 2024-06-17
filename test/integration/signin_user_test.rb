require "test_helper"

class SigninUserTest < ActionDispatch::IntegrationTest
    setup do
      @user = User.create(username: "johndoe", email: "johndoe@example.com",
                          password: "password", admin: false)
    end

    test "should login user" do
      post login_url, params: { session: { email: @user.email, password: 'password' } }
      assert_redirected_to user_url(@user)
      assert_equal 'Logged in successfully', flash[:notice]
      assert_equal @user.id, session[:user_id]
    end

    test "should not login with invalid credentials" do
      post login_url, params: { session: { email: @user.email, password: 'wrongpassword' } }
      assert_response :unprocessable_entity
      assert_equal 'There was something wrong with your login details', flash[:alert]
      assert_nil session[:user_id]
    end

end
