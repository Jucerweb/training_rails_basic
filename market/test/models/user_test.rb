require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should create user" do
    user = User.new(username: "Jucer", email: "jucerweb@gmail.com", password: "12345678")
    assert user.save
  end

  test "should create user without email" do
    user = User.new(username: "Jucer", password: "12345678")
    assert user.save
  end
end
