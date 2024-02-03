# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john_doe)
    @user.save
    @project = projects(:today)

    sign_in @user
  end

  test 'should get index' do
    get projects_path
    assert_response :success
  end

  test 'should get new' do
    get new_project_path
    assert_response :success
  end

  test 'should create project' do
    skip

    assert_difference('Project.count') do
      post projects_path, params: { project: { user_id: @user.id } }
    end

    assert_redirected_to project_path(Project.last)
  end

  test 'should show project' do
    get project_path(@project)
    assert_response :success
  end

  test 'should get edit' do
    get edit_project_path(@project)
    assert_response :success
  end

  test 'should update project' do
    skip
    patch project_path(@project), params: { project: {} }
    assert_redirected_to project_path(@project)
  end

  test 'should destroy project' do
    skip
    assert_difference('Project.count', -1) do
      delete project_path(@project)
    end

    assert_redirected_to projects_path
  end
end
