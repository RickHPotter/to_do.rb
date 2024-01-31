# frozen_string_literal: true

class NavBarComponent < ViewComponent::Base
  def initialize(logo:, items_left:, items_right:)
    @logo_partial = logo
    @items_left = items_left
    @items_right = items_right
    super
  end
end
