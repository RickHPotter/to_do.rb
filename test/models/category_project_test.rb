# frozen_string_literal: true

# == Schema Information
#
# Table name: category_projects
#
#  id           :bigint           not null, primary key
#  category_id  :bigint           not null
#  project_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class CategoryProjectTest < ActiveSupport::TestCase
  test 'should save category_project' do
    assert category_projects(:one).save, 'Failed to save category_project'
  end

  test 'should not save category_project without required attributes' do
    attributes = %i[category_id project_id]
    assert_presence_of_required_attribute(category_projects(:one), attributes)
  end

  test 'should not save category_project with existing unique combination %i[category_id project_id]' do
    attributes = %i[category_id project_id]
    assert_not_recurring_combination(category_projects(:one), category_projects(:two), attributes)
  end

  test 'should respond to belongs_to :category and :project' do
    assert_respond_to category_projects(:one), :category
    assert_respond_to category_projects(:one), :project
  end
end
