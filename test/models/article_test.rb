require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                        password: "password", admin: false)
    @category = Category.create(name: 'sports')
    @article = @user.articles.new(title: "Lorem", description: "Lorem ipsum dolor sit amet", category_ids: [@category.id])
  end
  # validation
  test "article should be valid" do
    assert @article.valid?
  end

  test "title should be present" do
    @article.title = " "
    assert_not @article.valid?
  end

  test "description should be present" do
    @article.description = " "
    assert_not @article.valid?
  end

  test "title should not be too short" do
    @article.title = "a" * 0
    assert_not @article.valid?
  end

  test "title should not be too long" do
    @article.title = "a" * 11
    assert_not @article.valid?
  end

  test "description should not be too short" do
    @article.description = "a" * 0
    assert_not @article.valid?
  end

  test "description should not be too long" do
    @article.description = "a" * 101
    assert_not @article.valid?
  end

  # relation
  test "article should belong to a user" do
    @article.user = nil
    assert_not @article.valid?
  end

  # test "article can have many categories" do
  #   @article.categories << Category.new(name: 'technology')
  #   @article.categories << Category.new(name: 'technology2')
  #   @article.save
  #   assert_equal 3, @article.categories.count
  # end
end
