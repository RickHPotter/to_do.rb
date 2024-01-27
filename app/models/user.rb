# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# @class [User] -> Devise
#
class User < ApplicationRecord
  # @extends ..................................................................
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  # @validations ..............................................................
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { in: 6..22 }

  # @callbacks ................................................................
  # @scopes ...................................................................
  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  #
  # Helper methods to return a full name based on `first_name` and `last_name`.
  #
  # @return [String]
  #
  def full_name
    "#{first_name} #{last_name}"
  end

  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
