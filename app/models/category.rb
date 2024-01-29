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
class Category < ApplicationRecord
  belongs_to :team
end
