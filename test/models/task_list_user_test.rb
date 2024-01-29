# frozen_string_literal: true

# == Schema Information
#
# Table name: task_list_users
#
#  id           :bigint           not null, primary key
#  task_list_id :bigint           not null
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class TaskListUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
