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
class Task < ApplicationRecord
  belongs_to :task_list
  belongs_to :assignee, class_name: :User, foreign_key: :assignee_id, optional: true
end
