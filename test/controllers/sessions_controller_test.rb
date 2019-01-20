require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new session" do
    get login_path
    assert_response :success
    assert_select "title", full_title("Log in")
  end

end
