require "test_helper"

class UserTest < ActiveSupport::TestCase
test "requires a name " do
  @user = User.new(name: "", email: "test@test.com", password: "password")
  assert_not @user.valid?

  @user.name = "John Doe"
  assert @user.valid?
end

test "requires a valid email" do
  @user = User.new(name: "John Doe", email: "", password: "password")
  assert_not @user.valid?

  @user.email = "invalid"
  assert_not @user.valid?

  @user.email = "test@test.com"
  assert @user.valid?
end

test "requires a unique email" do
  @existing_user = User.create(name: "John Doe", email: "test@test.com", password: "password")
  assert @existing_user.persisted?

  @new_user = User.new(name: "Jane Doe", email: "test@test.com", password: "password")
  assert_not @new_user.valid?
end

test "name and email is stripped of whitespace before saving" do
  @user = User.create(name: "John Doe ", email: "  test@test.com  ", password: "password")
  assert_equal "John Doe", @user.name
  assert_equal "test@test.com", @user.email
end

test "password length must be between 6 and ActiveModel's maximum" do
  @user = User.new(name: "John Doe", email: "test@test.com", password: "")
  assert_not @user.valid?

  @user.password = "password"
  assert @user.valid?

  max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
  @user.password = "a" * (max_length + 1)
  assert_not @user.valid?
end
end
