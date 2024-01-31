# frozen_string_literal: true

# Component to render the Team Section
class TeamsCardComponent < ViewComponent::Base
  def initialize(title:, description:, creator:, members: [])
    @title = title
    @description = description
    @creator = creator
    @members = members
    super
  end
end
