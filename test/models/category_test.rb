require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    # @category = create(:category)
    @category = Category.create(name: 'Sports')

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
    @category2 = Category.create(name: 'Sports')
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
    @user = User.create(username: "johndoee", email: "johndoe@example.com",
                        password: "password", admin: false)

    2.times do
      # article= build(:article,user:@user)
      @article = @user.articles.new(title: "Lorem", description: "Lorem ipsum dolor sit amet")
      @category.articles << @article
      @category.save
    end
    assert_equal 2, @category.articles.count
  end
end
