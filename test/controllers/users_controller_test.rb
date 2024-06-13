require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                        password: "password", admin: false)
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
    assert_difference("User.count",1) do
      post users_url, params: { user: { username: "test", email: "test@example.com",
                                        password: "password",admin:false} }
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

  # test "should update user" do
  #   sign_in_as(@user)
  #   patch user_url(@user), params: { username: "update", email: "johndoe@example.com",
  #                                    password: "password", admin: false }
  #   assert_redirected_to user_url(@user)
  # end
  #
  # test "should destroy user" do
  #   @category = Category.create(name: 'sports')
  #   @article = Article.create(title: "Lorem", description: "Lorem ipsum dolor sit amet", user:@user, category_ids: [@category.id])
  #
  #   sign_in_as(@user)
  #   assert_difference("User.count", -1) do
  #     assert_difference('Article.count', -@user.articles.count) do
  #       delete user_url(@user)
  #     end
  #   end
  #
  #   assert_nil session[:user_id]
  #   assert_redirected_to articles_path
  # end
end
