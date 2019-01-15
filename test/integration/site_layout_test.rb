require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
      get root_path
      # is the homepage rendered with the correct view ?
      assert_template 'static_pages/home'
      # 2 weil einmal logo hat ein rootlink und Home
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
      assert_select "a[href=?]", signup_path
      
      get contact_path
      assert_select "title", full_title("Contact")
      get signup_path
      assert_select "title", full_title("Sign Up")
    end
  end
