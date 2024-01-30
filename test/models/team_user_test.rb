# frozen_string_literal: true

# == Schema Information
#
# Table name: team_users
#
#  id         :bigint           not null, primary key
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#  admin      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TeamUserTest < ActiveSupport::TestCase
  test 'should save team_user' do
    assert team_users(:one).save, 'Failed to save the association Team User'
  end

  test 'should not save team_user without required attributes' do
    attributes = %i[team_id user_id admin]
    assert_presence_of_required_attribute(team_users(:one), attributes)
  end

  test 'should respond to belongs_to :team and :user' do
    assert_respond_to team_users(:one), :team
    assert_respond_to team_users(:one), :user
  end
end
