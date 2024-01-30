# frozen_string_literal: true

# == Schema Information
#
# Table name: category_task_lists
#
#  id           :bigint           not null, primary key
#  category_id  :bigint           not null
#  task_list_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class CategoryTaskListTest < ActiveSupport::TestCase
  test 'should save category_task_list' do
    assert category_task_lists(:one).save, 'Failed to save category_task_list'
  end

  test 'should not save category_task_list without required attributes' do
    attributes = %i[category_id task_list_id]
    assert_presence_of_required_attribute(category_task_lists(:one), attributes)
  end

  test 'should not save category_task_list with existing unique combination %i[category_id task_list_id]' do
    attributes = %i[category_id task_list_id]
    assert_not_recurring_combination(category_task_lists(:one), category_task_lists(:two), attributes)
  end

  test 'should respond to belongs_to :category and :task_list' do
    assert_respond_to category_task_lists(:one), :category
    assert_respond_to category_task_lists(:one), :task_list
  end
end
