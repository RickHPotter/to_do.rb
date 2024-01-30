# frozen_string_literal: true

# == Schema Information
#
# Table name: task_lists
#
#  id             :bigint           not null, primary key
#  task_list_name :string           not null
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
class TaskList < ApplicationRecord
  # @extends ..................................................................
  enum policy: { public: 0, protected: 1, private: 2 }, _prefix: true
  enum priority: { low: 0, medium: 1, high: 2 }, _prefix: true

  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :team
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  has_many :tasks
  has_many :task_list_users
  has_many :users, through: :task_list_users

  # @validations ..............................................................
  validates :task_list_name, :policy, :progress, :priority, :due_date, presence: true
  validates :task_list_name, uniqueness: { scope: :creator_id }
  validate :check_if_creator_is_in_team

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # Helper method to retrieve the creator and the team users.
  #
  # @return [Array]
  #
  def members
    [creator, *users]
  end

  # @protected_instance_methods ...............................................

  protected

  # The `creator` of a task_list should always be in the team that the task_list
  # belongs to.
  #
  # @return [Boolean]
  #
  def check_if_creator_is_in_team
    return if errors.any?
    return if team.members.include?(creator)

    errors.add(:creator, 'is not in the team')
    false
  end

  # @private_instance_methods .................................................
end
