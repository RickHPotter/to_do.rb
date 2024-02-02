# frozen_string_literal: true

# Component to render the Team Section
class TeamsCardComponent < ViewComponent::Base
  # Initialises a Component of Type TeamsCard
  #
  # @param title [String] The title of the card
  # @param description [String] The description of the card
  # @param creator [String] The creator of the card
  # @param members [Array] The members of the card
  #
  # @return [TeamsCardComponent] A new instance of TeamsCardComponent
  #
  def initialize(title:, description:, creator:, members: [])
    @title = title
    @description = description
    @creator = creator
    @members = members
    super
  end
end
