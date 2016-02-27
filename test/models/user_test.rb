require 'test_helper'

class UserTest < ActiveSupport::TestCase

def setup
	@user = User.new(username: "gyui", email: "sdf@example.com")
end

test "password should be atleast 8 characters" do
	@user.password = "asdf"
	assert_not @user.valid?
end

test "password should have atleast one number,one symbol,one uppercase" do
	@user.password = "FORDfiesta123"
	assert_not @user.valid?
end

test "username should be unique" do
	@user.save
	@user2 = User.new(username: "gyui")
	assert_not @user2.valid?
end

test "email address should be unique" do
	@user.save
	@user2 = User.new(username: "dfgghhh", email: "sdf@example.com")
	assert_not @user2.valid?
end
end