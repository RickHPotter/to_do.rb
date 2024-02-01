# frozen_string_literal: true

# == Schema Information
#
# Table name: project_users
#
#  id           :bigint           not null, primary key
#  project_id :bigint           not null
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class ProjectUserTest < ActiveSupport::TestCase
  test 'should save team_user' do
    assert project_users(:one).save, 'Failed to save the association Team User'
  end

  test 'should not save team_user without required attributes' do
    attributes = %i[project_id user_id]
    assert_presence_of_required_attribute(project_users(:one), attributes)
  end

  test 'should not save project_user with existing unique combination %i[project user]' do
    attributes = %i[project_id user_id]
    assert_not_recurring_combination(project_users(:one), project_users(:two), attributes)
  end

  test 'should respond to belongs_to :team and :user' do
    assert_respond_to project_users(:one), :project
    assert_respond_to project_users(:one), :user
  end
end
