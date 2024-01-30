# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  task_name    :string           not null
#  description  :text
#  order        :integer          default(0), not null
#  progress     :integer          default(0), not null
#  priority     :integer          default(0), not null
#  due_date     :date             default(Mon, 29 Jan 2024), not null
#  task_list_id :bigint           not null
#  assignee_id  :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Task < ApplicationRecord
  # @extends ..................................................................
  enum priority: { low: 0, medium: 1, high: 2 }, _prefix: true

  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :task_list
  belongs_to :assignee, class_name: :User, foreign_key: :assignee_id, optional: true

  # @validations ..............................................................
  validates :task_name, :order, :progress, :priority, :due_date, presence: true
  validates :task_name, uniqueness: { scope: %i[task_list_id assignee_id] }
  validate :check_if_assignee_is_in_task_list

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @protected_instance_methods ...............................................

  protected

  # The `assignee` of a task should always be in the task_list that the task
  # belongs to.
  #
  # @return [Boolean]
  #
  def check_if_assignee_is_in_task_list
    return if errors.any?
    return if task_list.members.include?(assignee)

    errors.add(:assignee, 'is not in the task_list')
    false
  end

  # @private_instance_methods .................................................
end
