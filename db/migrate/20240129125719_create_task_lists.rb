# frozen_string_literal: true

# TaskList Migration
class CreateTaskLists < ActiveRecord::Migration[7.1]
  def change
    create_table :task_lists do |t|
      t.string :task_list_name, null: false
      t.text :description
      t.integer :policy, null: false, default: 0
      t.integer :progress, null: false, default: 0
      t.integer :priority, null: false, default: 0
      t.date :due_date, null: false

      t.references :team, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :task_lists, %i[task_list_name creator_id], unique: true
  end
end
