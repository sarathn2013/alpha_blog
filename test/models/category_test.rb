require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

	def setup
    @category = Category.new(name: "sports")
	end

	test "Category should be valid" do
		assert @category.valid?
	end

	test "Category should not be empty" do
		@category.name = " "
		assert_not @category.valid?
	end

	test "Categories should have different names" do
		@category.save
		@category2 = Category.new(name: "sports")
		assert_not @category2.valid?
	end

	test "category name should not be too large" do
		@category.name = "a" * 26
		assert_not @category.valid?
	end

	test "category name should not be too small" do
		@category.name = "aa" 
		assert_not @category.valid?
	end


end
