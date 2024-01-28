# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  team_name   :string           not null
#  description :text
#  creator_id  :bigint           not null
#  policy      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'should save team' do
    assert teams(:sept).save, 'Saved the team'
  end

  test 'should not save team without a team_name' do
    team = teams(:sept).dup
    team.team_name = nil
    assert_not team.save, 'Saved the team without a team_name'
  end

  test 'should not save team without a creator' do
    team = teams(:mizu).dup
    team.creator = nil
    assert_not team.save, 'Saved the team without a creator'
  end

  test 'should not save team with a repeating team_name in the scope of the creator' do
    team_one = teams(:sept)
    team_two = teams(:sept).dup
    creator = users(:lovelace)

    assert team_one.update(creator:)
    assert_not team_two.update(creator:), 'Saved the team with a repeating team_name in the scope of the creator'
  end

  test 'should respond to belongs_to :creator' do
    assert_respond_to teams(:sept), :creator
  end
end
