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
    get root_path
    assert_redirect_to_sign_in
  end

  test 'should create valid user' do
    password = Faker::Internet.password
    user = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password:, password_confirmation: password
    }

    post user_registration_path, params: { user: }

    assert_response :redirect
    assert_match I18n.t('devise.registrations.signed_up'), flash[:notice]
    assert_redirected_to root_path
  end
end
