# frozen_string_literal: true

# Component to render an autocomplete select
class RadioButtonComponent < ViewComponent::Base
  # @includes .................................................................
  include TranslateHelper

  # @security (i.e. attr_accessible) ..........................................
  attr_reader :form, :field, :id, :items

  # Initialises a Component of Type RadioButton
  #
  # @param form [ActionView::Helpers::FormBuilder] The form builder object.
  # @param field [Symbol] The attribute name for the radio button.
  # @param items [Array] The list of items for the select field.
  #
  # @return [RadioButtonComponent] A new instance of RadioButtonComponent.
  #
  def initialize(form:, field:, items:)
    @form = form
    @field = field
    @items = items
    super
  end

  def radio_id(item)
    "#{form.object.class.model_name.singular}_#{field}_#{item}"
  end
end
