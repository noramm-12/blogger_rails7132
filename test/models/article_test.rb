require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @category = create(:category)
    @user = create(:no_admin_user)
    @article = create(:article,user:@user,category_ids: [@category.id])
    # @article = @user.articles.new(title: "Lorem", description: "Lorem ipsum dolor sit amet", category_ids: [@category.id])
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

  test "article can have many categories" do
    @article.categories << build(:category,:category2)
    @article.categories << build(:category,:category3)
    @article.save
    assert_equal 3, @article.categories.count
  end
end
