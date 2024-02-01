# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id             :bigint           not null, primary key
#  project_name :string           not null
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

class ProjectTest < ActiveSupport::TestCase
  test 'should save the project' do
    project = projects(:today)
    assert project.save, 'Failed to save the project'
  end

  test 'should not save project without required attributes' do
    attributes = %i[project_name policy progress priority due_date team_id creator_id]
    assert_presence_of_required_attribute(projects(:today), attributes)
  end

  test 'should not save project with existing unique combination %i[project_name creator]' do
    attributes = %i[project_name creator_id]
    assert_not_recurring_combination(projects(:today), projects(:never), attributes)
  end

  test 'should not save task by creator that does not belongs to the team' do
    project = projects(:today)
    creator = User.create(
      first_name: 'Giselly', last_name: 'Soares', email: Faker::Internet.email, password: '123123'
    )

    assert_not project.update(creator:), 'Saved the project with a creator that does not belong to the team'
    assert project.errors.include?(:creator)
  end

  test 'should respond to belongs_to :tasks' do
    assert_respond_to projects(:today), :tasks
  end
end
