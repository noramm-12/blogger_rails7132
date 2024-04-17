require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    # @category = categories(:one)
    @admin_user=User.create(username: "johndoe", email: "johndoe@example.com",
                            password: "password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: 'Sports' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports",response.body #確保響應體中包含新創建的類別名稱
  end

  test "get new category form and reject invalid category submissions" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_difference('Category.count',0) do
      post categories_url, params: { category: { name: ' ' } }
    end
    assert_select "div.alert"
    assert_match "errors",response.body #確保響應體中包含新創建的類別名稱
  end
end
