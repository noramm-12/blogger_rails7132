require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create(:no_admin_user)
  end

  # Validation tests
  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should not be too short" do
    @user.username = "a" * 2
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 26
    assert_not @user.valid?
  end

  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 101 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should accept valid format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email should reject invalid format" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
