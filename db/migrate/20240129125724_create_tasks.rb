# frozen_string_literal: true

# Task Migration
class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :task_name, null: false
      t.text :description
      t.integer :order, null: false, default: 0
      t.integer :progress, null: false, default: 0
      t.integer :priority, null: false, default: 0
      t.date :due_date, null: false, default: Date.today

      t.references :task_list, null: false, foreign_key: true
      t.references :assignee, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :tasks, %i[task_name task_list_id assignee_id], unique: true
  end
end
