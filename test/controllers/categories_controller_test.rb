require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = create(:category)
    @user = create(:no_admin_user)
    @admin_user = create(:admin_user)
  end

  test 'should get index' do
    get categories_url
    assert_response :success
  end

  test 'should get show' do
    get category_url(@category)
    assert_response :success
  end

  test 'should get new' do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test 'should create category' do
    sign_in_as(@admin_user)
    # 確保在執行指定區塊之後，Category 模型的數量增加了 1
    assert_difference('Category.count', 1) do
      post categories_url, params: { category:attributes_for(:category,:category2)}
    end
    assert_redirected_to category_url(Category.last)
  end

  test "should get edit" do
    sign_in_as(@admin_user)
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    sign_in_as(@admin_user)
    patch category_url(@category), params: { category: { name: 'updated' } }
    assert_redirected_to category_url(@category)
    @category.reload
    assert_equal "updated", @category.name
  end

#admin相關測試
  test 'should not get new category if not admin' do
    get new_category_url
    assert_redirected_to categories_url
    assert_equal "Only admins can perform that action", flash[:alert]
  end

  test 'should not create category if not admin' do
    # 確保在執行指定區塊之後，Category 模型的數量增加了 1
    assert_no_difference('Category.count') do
      post categories_url, params: { category: attributes_for(:category,:category2)}
    end
    assert_redirected_to categories_url
  end

  test 'should not get edit if not admin' do
    get edit_category_url(@category)
    assert_redirected_to categories_url
    assert_equal "Only admins can perform that action", flash[:alert]
  end

  test 'should not update category if not admin' do
    patch category_url(@category), params: { category: { name: 'Travel' } }
    assert_redirected_to categories_url
    assert_equal "Only admins can perform that action", flash[:alert]
  end
end
