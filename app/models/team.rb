# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  team_name   :string           not null
#  description :text
#  creator_id  :bigint           not null
#  policy      :integer          default("public"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Team < ApplicationRecord
  # @extends ..................................................................
  enum policy: { public: 0, protected: 1, private: 2 }, _prefix: true

  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users

  # @validations ..............................................................
  validates :team_name, presence: true, uniqueness: { scope: :creator_id }

  # @callbacks ................................................................
  # @scopes ...................................................................
  scope :by_user, ->(user) { joins(:team_users).where(team_users: { user: }) }

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
  # @private_instance_methods .................................................
end
