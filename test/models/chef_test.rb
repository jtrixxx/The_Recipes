require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "foxbase", email: "foxbase@example.com")
	end

	test "chef should be valid" do 
		assert @chef.valid?
	end

	test "chefname must be present" do 
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "chefname should not be too long" do 
		@chef.chefname = "a" * 41
		assert_not @chef.valid?
	end

	test "chefname should not be too short" do 
		@chef.chefname = "aa"
		assert_not @chef.valid?
	end

	test "email should be present" do 
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email should be within bounds" do 
		@chef.email = "a" * 101 + "@example.com"
		assert_not @chef.valid? 
	end

	test "email address should be unique" do 
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		assert_not dup_chef.valid?
	end

	test "email validation should accept valid address" do 
		valid_address = %w[user@ee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
		valid_address.each do |va|
		@chef.email = va 
		assert @chef.valid?
	end
	end

	test "email validation should reject invalid address" do 
		invalid_address = %w[user@example,com user_at_eee.org user.name@example. ee@i_am_.com foo@ee+aar.com]
		invalid_address.each do |ia|
		@chef.email = ia
		assert_not @chef.valid?
	end
	end
end