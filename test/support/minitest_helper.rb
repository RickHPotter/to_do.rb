# frozen_string_literal: true

module MinitestHelper
  # Asserts that the object should only be saved with given attributes
  #
  # @param [ActiveRecord::Base] object
  # @param [Array<Symbol>] attributes
  #
  # @return [void]
  #
  def assert_presence_of_required_attribute(object, attributes)
    attributes.each do |attribute|
      object[attribute] = nil
      assert_not object.save, "Saved the #{object.model_name} without a/an #{attribute}"
    end
  end

  # Asserts that the object should only be saved with unique combination of given attributes
  #
  # @param [ActiveRecord::Base] object
  # @param [Array<Symbol>] attributes
  #
  # @return [void]
  #
  def assert_not_recurring_combination(object, helper, attributes)
    singular = object.model_name

    helper.assign_attributes(object.attributes.slice(*attributes.map(&:to_s)))
    assert object.save
    assert_not helper.valid?, "Validated the #{singular} with unique combination #{attributes.join(', ')}"
    assert helper.errors.messages.keys.uniq.intersect?(attributes)
  end
end
