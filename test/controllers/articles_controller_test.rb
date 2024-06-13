require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @article = articles(:one)
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                        password: "password", admin: false)
    @admin_user = User.create(username: "admin", email: "admin@example.com",
                              password: "password", admin: true)
    @category = Category.create(name: 'sports')
    @article = Article.create(title: "Lorem", description: "Lorem ipsum dolor sit amet", user:@user, category_ids: [@category.id])
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
      post articles_url, params: { article: {title: "Lorem", description: "Lorem ipsum dolor sit amet", user:@user,category_ids: [@category.id]  } }
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
    patch article_url(@article), params: { article: {title: "update", description: "Lorem ipsum dolor sit amet", user:@user,category_ids: [@category.id]  } }
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
    patch article_url(@article), params: { article: {title: "update", description: "Lorem ipsum dolor sit amet", user:@user,category_ids: [@category.id]  } }
    assert_redirected_to article_url(@article)
  end

  test "admin can delete other user's article" do
    # @other_article = Article.create(title: "Lorem", description: "Lorem ipsum dolor sit amet", user:@user, category_ids: [@category.id])
    sign_in_as(@admin_user)
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end

  test "should not update other user's article if not admin" do
    @other_user=User.create(username: "other", email: "other@example.com",
                            password: "password", admin: false)
    sign_in_as(@other_user)
    original_title = @article.title
    original_description = @article.description

    patch article_url(@article), params: { article: { title: "Update Attempt", description: "Update attempt", user: @other_user, category_ids: [@category.id] } }

    @article.reload
    assert_equal original_title, @article.title
    assert_equal original_description, @article.description
    assert_equal "You can only edit or delete your own article", flash[:alert]
  end
  test "should not delete other user's article if not admin" do
    @other_user=User.create(username: "other", email: "other@example.com",
                            password: "password", admin: false)
    sign_in_as(@other_user)
    assert_no_difference('Article.count') do
      delete article_url(@article)
    end
    assert_redirected_to article_url(@article)
    assert_equal "You can only edit or delete your own article", flash[:alert]
  end
end
