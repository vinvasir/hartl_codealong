require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	def setup
  	@user = { 	user: { name:  "Heebee",
                             email: "user@valid.com",
                             password:              "COOL!foobar",
                             password_confirmation: "COOL!foobar" } }
		@invalid_user = { 	user: { name:  "",
                             email: "user@valid.com",
                             password:              "foo",
                             password_confirmation: "COOL!foobar" } }                       
	end

  test "valid signup info increases User count" do                                     
    get signup_path
    assert_difference 'User.count' do
      post signup_path, @user
    end
    assert_response :redirect
    follow_redirect!
    assert_template 'users/show'
    assert_select "div.alert-success", "Welcome to the Sample App!"
    assert is_logged_in?
  end

  test "invalid signup info does not save" do
    get signup_path
	  assert_no_difference 'User.count' do
	    post signup_path, @invalid_user
	  end
    assert_template 'users/new'
    assert_not is_logged_in?
  end

  test "invalid signup info results in correct error messages" do
  	get signup_path
  	post signup_path, @invalid_user
  	assert_template 'users/new'
  	error_msg = "#error_explanation ul li"
  	assert_select error_msg, "Name can't be blank"
  	assert_select error_msg, "Password confirmation doesn't match Password"
  	assert_select error_msg, "Password is too short (minimum is 6 characters)"
    assert_not is_logged_in?
  end  
end
