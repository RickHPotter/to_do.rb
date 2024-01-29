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
    assert tasks(:wash_car).save, 'Saved the task'
  end

  %i[task_name order progress priority due_date task_list_id].each do |attribute|
    test "should not save task without #{attribute}" do
      task = tasks(:wash_car)
      task[attribute] = nil
      assert_not task.save, "Saved the task without a/an #{attribute}"
    end
  end

  test 'should not save task with existing unique combination %i[task_name task_list assignee]' do
    task1 = tasks(:wash_car)
    task2 = tasks(:work_out).dup
    task2.assign_attributes(task1.attributes.slice('task_name', 'task_list_id', 'assignee_id'))

    assert task1.save
    assert_not task2.save, 'Saved the task with existing unique combination'
  end

  test 'should not save task with assignee that does not belong to task_list' do
    # TODO: implement after testing TaskListUser
    skip
  end
end
