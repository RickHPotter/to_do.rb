# frozen_string_literal: true

# CategoryTaskList Migration
class CreateCategoryTaskLists < ActiveRecord::Migration[7.1]
  def change
    create_table :category_task_lists do |t|
      t.references :category, null: false, foreign_key: true
      t.references :task_list, null: false, foreign_key: true

      t.timestamps
    end

    add_index :category_task_lists, %i[category_id task_list_id], unique: true
  end
end
