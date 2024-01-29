# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_name :string           not null
#  description   :text
#  team_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'should save category' do
    assert categories(:chore).save, 'Saved the category'
  end

  %i[category_name team_id].each do |attribute|
    test "should not save category without #{attribute}" do
      category = categories(:chore)
      category[attribute] = nil
      assert_not category.save, "Saved the category without a/an #{attribute}"
    end
  end

  test 'should not save category with duplicate name in the same team' do
    category1 = categories(:chore)
    category2 = categories(:healthy)
    category2.category_name = category1.category_name
    category2.team = category1.team

    assert category1.save
    assert_not category2.save, 'Saved the category with duplicate name in the same team'
  end

  test 'should respond to belongs_to :team' do
    assert_respond_to categories(:chore), :team
  end
end
