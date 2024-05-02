require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    # @category = categories(:one)
    @category = Category.new(name: 'sports')
  end
  #validation
  test 'category should be valid' do
    assert @category.valid?
  end
  test 'name should be present' do
    @category.name = ' '
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    @category2 = Category.new(name: 'sports')
    assert_not @category2.valid?
  end

  test 'name should not be too long' do
    @category.name = 'a' * 26
    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = 'aa'
    assert_not @category.valid?
  end

  # relation
  test "category can have many articles" do
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                        password: "password", admin: false)
    @category.articles << Article.new(title: "Lorem", description: "Lorem ipsum dolor sit amet", user:@user)
    @category.articles << Article.new(title: "Lorem", description: "Lorem ipsum dolor sit amet", user:@user)
    @category.save
    assert_equal 2, @category.articles.count
  end
end
