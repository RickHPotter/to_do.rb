# frozen_string_literal: true

# TaskListUser Migration
class CreateTaskListUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :task_list_users do |t|
      t.references :task_list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :task_list_users, %i[task_list_id user_id], unique: true
  end
end
