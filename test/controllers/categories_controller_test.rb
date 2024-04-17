require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @category = categories(:one)
    @category = Category.create(name: 'Sports')
    @admin_user=User.create(username: "johndoe", email: "johndoe@example.com",
                            password: "password", admin: true)
  end

  test 'should get index' do
    get categories_url
    assert_response :success
  end

  test 'should get new' do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test 'should create category' do
    sign_in_as(@admin_user)
    #確保在執行指定區塊之後，Category 模型的數量增加了 1
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: 'Travel' } }
    end
    #確保該請求被成功重定向到了最後創建的類別的 URL
    assert_redirected_to category_url(Category.last)
  end

  test 'should not create category if not admin' do
    #確保在執行指定區塊之後，Category 模型的數量增加了 1
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: 'Travel' } }
    end
    #確保該請求被成功重定向到了最後創建的類別的 URL
    assert_redirected_to categories_url
  end

  test 'should show category' do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference("Category.count", -1) do
  #     delete category_url(@category)
  #  assert_redirected_to categories_url
  # end
end
