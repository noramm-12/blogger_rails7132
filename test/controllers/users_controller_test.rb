require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user=create(:no_admin_user)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    # @admin_user=create(:admin_user)
    assert_difference("User.count",1) do
      post users_url, params: { user: attributes_for(:admin_user)} # Assuming another user exists
    end
    assert_redirected_to articles_url
    assert session[:user_id].present?
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    sign_in_as(@user)
    patch user_url(@user), params: { user: { username: "newusername", email: "normal@example.com", password: "password"} }

    assert_redirected_to user_url(@user)
    @user.reload
    assert_equal "newusername", @user.username
  end
  test "should destroy user" do
    @admin_user = create(:admin_user)
    sign_in_as @admin_user # Sign in as @user
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to articles_url
  end
  #admin
  test "should not allow edit if not logged in" do
    get edit_user_url(@user)
    assert_redirected_to login_url
  end

  test "should not allow update if not logged in" do
    patch user_url(@user), params: {user:{ username: "newusername", email: "johndoe@example.com",
                                           password: "password", admin: false }}
    assert_redirected_to login_url
    @user.reload
    refute_equal "newusername", @user.username
  end
  test "should not allow edit if not the same user" do
    @other_user = User.create(username: "johndoe2", email: "johndoe2@example.com",
                                         password: "password", admin: false) # Assuming another user exists
    sign_in_as @other_user
    get edit_user_url(@user)
    assert_redirected_to user_url(@user)
    assert_equal 'You can only edit your own profile', flash[:alert]
  end

  test "should not allow update if not the same user" do
    @other_user = User.create(username: "johndoe2", email: "johndoe2@example.com",
                        password: "password", admin: false)
    sign_in_as @other_user
    patch user_url(@user), params: { user: { username: "newusername" } }
    assert_redirected_to user_url(@user)
    assert_equal 'You can only edit your own profile', flash[:alert]
    @user.reload
    refute_equal "newusername", @user.username
  end
end
