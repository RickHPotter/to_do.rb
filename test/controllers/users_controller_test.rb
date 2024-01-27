# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john_doe)
    @user.save
  end

  test 'should successfully visit root_path after signing in' do
    sign_in @user

    get root_path
    assert_response :success
  end

  test 'should fail miserably trying to visit root_path without signing in' do
    # NOTE: this is not real case scenario, change route later
    get protected_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_match(/sign in/i, response.body)
  end
end
