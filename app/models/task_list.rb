# frozen_string_literal: true

# == Schema Information
#
# Table name: task_lists
#
#  id             :bigint           not null, primary key
#  task_list_name :string           not null
#  description    :text
#  policy         :integer          default(0), not null
#  progress       :integer          default(0), not null
#  priority       :integer          default(0), not null
#  due_date       :date             not null
#  team_id        :bigint           not null
#  creator_id     :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class TaskList < ApplicationRecord
  belongs_to :team
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
end
