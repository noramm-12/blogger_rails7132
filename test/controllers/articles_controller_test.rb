require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
        @category = create(:category)
        @user = create(:no_admin_user)
        @admin_user = create(:admin_user)
        @article = create(:article,user:@user,category_ids: [@category.id])
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user)
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    sign_in_as(@user)
    assert_difference("Article.count",1) do
      post articles_url, params: { article: attributes_for(:article,user:@user) }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    sign_in_as(@user)
    patch article_url(@article), params: { article: {title: "update", content: "Lorem ipsum dolor sit amet", user:@user,category_ids: [@category.id]  } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    sign_in_as(@user)
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end

  #admin相關測試
  test "admin can get edit of other user's article" do
    sign_in_as(@admin_user)
    get article_url(@article)
    assert_response :success
  end

  test "admin can update other user's article" do
    sign_in_as(@admin_user)
    patch article_url(@article), params: { article: {title: "update", content: "Lorem ipsum dolor sit amet", user:@user,category_ids: [@category.id]  } }
    assert_redirected_to article_url(@article)
  end

  test "admin can delete other user's article" do
    sign_in_as(@admin_user)
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end

  test "should not update other user's article if not admin" do
    @other_user=create(:no_admin_user, :no_admin_user2)
    sign_in_as(@other_user)
    original_title = @article.title
    original_content = @article.content

    patch article_url(@article), params: { article: { title: "Update Attempt", content: "Update attempt", user: @other_user, category_ids: [@category.id] } }

    @article.reload
    assert_equal original_title, @article.title
    assert_equal original_content, @article.content
    assert_equal "You can only edit or delete your own article", flash[:alert]
  end
  test "should not delete other user's article if not admin" do
    @other_user=create(:no_admin_user, :no_admin_user2)

    sign_in_as(@other_user)
    assert_no_difference('Article.count') do
      delete article_url(@article)
    end
    assert_redirected_to article_url(@article)
    assert_equal "You can only edit or delete your own article", flash[:alert]
  end
end
