# frozen_string_literal: true

require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john_doe)
    @user.save
  end

  test 'should not access teams if not logged in' do
    get teams_path
    assert_redirect_to_sign_in
  end

  test 'should access teams#index if logged in' do
    sign_in @user

    get teams_path
    assert_response :success
  end

  test 'should access teams#new if logged in' do
    sign_in @user

    get new_team_path
    assert_response :success
  end

  test 'should access teams#create if logged in' do
    skip

    sign_in @user

    team = { team_name: 'My Beloved Team', description: 'My lovely team', policy: :public }
    post teams_path, params: { team: }

    assert_response :success
    assert_match "Created 'My Beloved Team' successfully", flash[:notice]
    assert_redirected_to teams_path
  end

  test 'should access teams#edit if logged in' do
    skip

    sign_in @user
    team = teams(:sept)
    team.save # gotta check if I need to do this

    get edit_team_path, params: { id: team.id }

    assert_response :success
    assert_match team.team_name, response.body
  end

  test 'should access teams#update if logged in' do
    skip

    sign_in @user
    team = teams(:sept)
    team.save

    team = { team_name: 'My Beloved Team', description: 'My lovely team', policy: :public }
    patch team_path, params: { id: team.id, team: }

    assert_response :success
    assert_match "Updated 'My Beloved Team' successfully", flash[:notice]
  end

  test 'should access teams#destroy if logged in' do
    skip

    sign_in @user
    team = teams(:sept)
    team.save

    delete team_path, params: { id: team.id }

    assert_response :success
    assert_match "Deleted 'My Beloved Team' successfully", flash[:notice]
    assert_redirected_to teams_path
    assert_nil Team.find_by(id: team.id)
  end
end
