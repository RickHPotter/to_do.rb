# frozen_string_literal: true

# == Schema Information
#
# Table name: task_list_users
#
#  id           :bigint           not null, primary key
#  task_list_id :bigint           not null
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class TaskListUserTest < ActiveSupport::TestCase
  test 'should save team_user' do
    assert task_list_users(:one).save, 'Failed to save the association Team User'
  end

  test 'should not save team_user without required attributes' do
    attributes = %i[task_list_id user_id]
    assert_presence_of_required_attribute(task_list_users(:one), attributes)
  end

  test 'should not save task_list_user with existing unique combination %i[task_list user]' do
    attributes = %i[task_list_id user_id]
    assert_not_recurring_combination(task_list_users(:one), task_list_users(:two), attributes)
  end

  test 'should respond to belongs_to :team and :user' do
    assert_respond_to task_list_users(:one), :task_list
    assert_respond_to task_list_users(:one), :user
  end
end
