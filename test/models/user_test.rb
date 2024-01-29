# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should save user' do
    assert users(:john_doe).save, 'Saved the user'
  end

  %i[first_name last_name].each do |attribute|
    test "should not save user without #{attribute}" do
      user = users(:john_doe)
      user[attribute] = nil
      assert_not user.save, "Saved the user without a/an #{attribute}"
    end
  end

  test '#full_name should return a full name based on first_name and last_name' do
    assert_equal 'Jane Doe', users(:jane_doe).full_name
  end

  test 'should not save with password less than 6 characters' do
    user = users(:john_doe).dup
    user.password = '12345'
    assert_not user.save, 'Saved the user with a password less than 6 characters'
  end

  test 'should not save with password_confirmation different from password' do
    user = users(:john_doe).dup
    user.password_confirmation = 'whatever'
    assert_not user.save, 'Saved the user with a password_confirmation different from password'
  end

  test 'should respond to has_many :team_users and :teams' do
    assert_respond_to users(:john_doe), :team_users
    assert_respond_to users(:john_doe), :teams
  end

  test 'should have a default team' do
    user = users(:lovelace)
    user.save

    assert_includes user.teams.pluck(:team_name), 'Default'
  end
end
