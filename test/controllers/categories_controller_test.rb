require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

	def setup
 		@category = Category.create(name: "fiction")
	  @user = User.create(username: "sarathchandra009", email: "s@gmail.com", password: "fordfiesta", admin: true)
  end

  test "should get categories index" do
  	 get :index
  	 assert_response :success
  end

  test "should get categories new" do
    session[:user_id] = @user.id
  	get :new
  	assert_response :success
  end

  test "should get categories show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
  assert_no_difference 'Category.count' do
    post :create, category: { name: "sports"}
  end
  assert_redirected_to categories_path
end
end
