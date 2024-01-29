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

  # @validations ..............................................................
  validates :team_name, presence: true, uniqueness: { scope: :creator }

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
