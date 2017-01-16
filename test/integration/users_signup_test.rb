require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup info does not save" do
    get signup_path
	  assert_no_difference 'User.count' do
	    post users_path, user: { name:  "",
	                             email: "user@invalid",
	                             password: "foo",
	                             password_confirmation: "bar" }
	  end
    #assert_template 'users/new'
  	assert_select 'title', 'Sign up'
  end

  test "valid signup info increases User count" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, { user: { name:  "Heebee",
                                         email: "user@valid.com",
                                         password:              "foobar",
                                         password_confirmation: "foobar" } }
    end
    #assert_template 'users/show'
  end
end
