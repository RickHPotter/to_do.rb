# frozen_string_literal: true

# == Schema Information
#
# Table name: task_lists
#
#  id             :bigint           not null, primary key
#  task_list_name :string           not null
#  description    :text
#  policy         :integer          default(0), not null
#  progress       :integer          default(0), not null
#  priority       :integer          default(0), not null
#  due_date       :date             not null
#  team_id        :bigint           not null
#  creator_id     :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'test_helper'

class TaskListTest < ActiveSupport::TestCase
  test 'should save the task_list' do
    task_list = task_lists(:today)
    assert task_list.save, 'Failed to save the task_list'
  end

  test 'should not save task_list without required attributes' do
    attributes = %i[task_list_name policy progress priority due_date team_id creator_id]
    assert_presence_of_required_attribute(task_lists(:today), attributes)
  end

  test 'should not save task_list with existing unique combination %i[task_list_name creator]' do
    attributes = %i[task_list_name creator_id]
    assert_not_recurring_combination(task_lists(:today), task_lists(:never), attributes)
  end

  test 'should only be created by someone that belongs to the team' do
    task_list = task_lists(:today)
    creator = User.create(
      first_name: 'Giselly', last_name: 'Soares', email: Faker::Internet.email, password: '123123'
    )

    assert_not task_list.update(creator:), 'Created the task_list with a creator that does not belong to the team'
    assert task_list.errors.include?(:creator)
  end

  test 'should respond to belongs_to tasks' do
    assert_respond_to task_lists(:today), :tasks
  end
end
