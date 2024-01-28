# frozen_string_literal: true

# == Schema Information
#
# Table name: team_users
#
#  id         :bigint           not null, primary key
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

require 'test_helper'

class TeamUserTest < ActiveSupport::TestCase
  test 'should save team_user' do
    assert team_users(:one).save, 'Saved the association Team User'
  end

  test 'should not save team_user without team' do
    team_user = team_users(:one).dup
    team_user.team_id = nil
    assert_not team_user.save, 'Saved the team_user without a team'
  end

  test 'should not save team_user without user' do
    team_user = team_users(:one).dup
    team_user.user_id = nil
    assert_not team_user.save, 'Saved the team_user without a user'
  end

  test 'should respond to belongs_to :team and :user' do
    assert_respond_to team_users(:one), :team
    assert_respond_to team_users(:one), :user
  end
end
