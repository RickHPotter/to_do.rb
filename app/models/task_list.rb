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
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :team
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  has_many :tasks

  # @validations ..............................................................
  validates :task_list_name, :policy, :progress, :priority, :due_date, presence: true
  validates :task_list_name, uniqueness: { scope: :creator }
  validate :check_if_creator_is_in_team

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @protected_instance_methods ...............................................

  protected

  def check_if_creator_is_in_team
    return if errors.any?
    return if team.members.include?(creator)

    errors.add(:creator, 'is not in the team')
    false
  end

  # @private_instance_methods .................................................
end
