# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  task_name    :string           not null
#  description  :text
#  order        :integer          default(0), not null
#  progress     :integer          default(0), not null
#  priority     :integer          default(0), not null
#  due_date     :date             default(Mon, 29 Jan 2024), not null
#  task_list_id :bigint           not null
#  assignee_id  :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'should save task' do
    assert tasks(:wash_car).save, 'Failed to save the task'
  end

  test 'should not save task without required attributes' do
    attributes = %i[task_name order progress priority due_date task_list_id]
    assert_presence_of_required_attribute(tasks(:wash_car), attributes)
  end

  test 'should not save task with existing unique combination %i[task_name task_list assignee]' do
    attributes = %i[task_name task_list_id assignee_id]
    assert_not_recurring_combination(tasks(:wash_car), tasks(:work_out), attributes)
  end

  test 'should not save task with assignee that does not belong to task_list' do
    # TODO: implement after testing TaskListUser
    skip
  end
end