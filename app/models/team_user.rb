# frozen_string_literal: true

# == Schema Information
#
# Table name: team_users
#
#  id         :bigint           not null, primary key
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#  admin      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TeamUser < ApplicationRecord
  # @extends ..................................................................
  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :team
  belongs_to :user

  # @validations ..............................................................
  validates :admin, inclusion: { in: [true, false] }

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @return [String]
  #
  def role
    return 'Admin' if admin

    'Member'
  end

  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
