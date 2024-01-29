# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  task_name    :string           not null
#  description  :text
#  order        :integer
#  progress     :integer
#  priority     :integer
#  due_date     :date
#  task_list_id :bigint           not null
#  assignee_id  :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
