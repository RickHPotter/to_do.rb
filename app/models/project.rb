# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id             :bigint           not null, primary key
#  project_name :string           not null
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
class Project < ApplicationRecord
  # @extends ..................................................................
  enum policy: { public: 0, protected: 1, private: 2 }, _prefix: true
  enum priority: { low: 0, medium: 1, high: 2 }, _prefix: true

  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :team
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  has_many :project_users
  has_many :users, through: :project_users

  has_many :tasks, inverse_of: :project, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank

  # @validations ..............................................................
  validates :project_name, :policy, :progress, :priority, :due_date, presence: true
  validates :project_name, uniqueness: { scope: :creator_id }
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
    [creator, *users].uniq
  end

  # @protected_instance_methods ...............................................

  protected

  # The `creator` of a project should always be in the team that the project
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
