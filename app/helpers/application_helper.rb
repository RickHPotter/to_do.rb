# frozen_string_literal: true

module ApplicationHelper
  # Generate a link to change the locale
  #
  # @param [Symbol] locale
  # @param [Proc] block
  #
  # @return [String]
  #
  def locale_link(locale, options = {}, &block)
    path = request.path
    path_with_locale = "#{path}?locale=#{locale}"
    link_to path_with_locale, class: options[:class], &block
  end
end
