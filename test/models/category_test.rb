require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = create(:category)
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
    @category2 = Category.create(name: 'Fashion')
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
    @user = create(:user)

    2.times do
      article= build(:article,user:@user)
      @category.articles << article
    end
    assert_equal 2, @category.articles.count
  end
end
