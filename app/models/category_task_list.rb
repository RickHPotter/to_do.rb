# frozen_string_literal: true

# == Schema Information
#
# Table name: category_task_lists
#
#  id           :bigint           not null, primary key
#  category_id  :bigint           not null
#  task_list_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class CategoryTaskList < ApplicationRecord
  belongs_to :category
  belongs_to :task_list
end
