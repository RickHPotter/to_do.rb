# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  task_name   :string           not null
#  description :text
#  order       :integer          default(0), not null
#  progress    :integer          default(0), not null
#  priority    :integer          default("low"), not null
#  due_date    :date             not null
#  project_id  :bigint           not null
#  assignee_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'should save task' do
    assert tasks(:wash_car).save, 'Failed to save the task'
  end

  test 'should not save task without required attributes' do
    attributes = %i[task_name progress priority due_date project_id]
    assert_presence_of_required_attribute(tasks(:wash_car), attributes)
  end

  test 'should not save task with existing unique combination %i[task_name project assignee]' do
    attributes = %i[task_name project_id assignee_id]
    assert_not_recurring_combination(tasks(:wash_car), tasks(:work_out), attributes)
  end

  test 'should not save task with assignee that does not belong to the project' do
    task = tasks(:wash_car)
    assignee = User.create(
      first_name: 'Lala', last_name: 'Souza', email: Faker::Internet.email, password: '123123'
    )

    assert_not task.update(assignee:), 'Saved the task with an assignee that does not belong to the project'
  end

  test 'should respond to belongs_to :project and :assignee' do
    assert_respond_to tasks(:wash_car), :project
    assert_respond_to tasks(:wash_car), :assignee
  end
end
