# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
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
class User < ApplicationRecord
  # @extends ..................................................................
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, password_length: 6..22

  # @includes .................................................................
  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users

  # @validations ..............................................................
  validates :first_name, :last_name, presence: true

  # @callbacks ................................................................
  after_validation :confirm_user
  after_validation :create_default_team

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

  protected

  # This is temporary
  # TODO: either put up a mail server or take down :confirmable
  def confirm_user
    self.confirmed_at = Date.current
  end

  # Creates built-in `categories` for given user.
  #
  # @return [void]
  #
  def create_default_team
    team_users.push TeamUser.new(
      team: Team.new(team_name: 'Default', creator: self, policy: :public),
      admin: true
    )
  end

  # @private_instance_methods .................................................
end
