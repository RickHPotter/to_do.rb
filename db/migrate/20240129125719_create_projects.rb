# frozen_string_literal: true

# Project Migration
class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :project_name, null: false
      t.text :description
      t.integer :policy, null: false, default: 0
      t.integer :progress, null: false, default: 0
      t.integer :priority, null: false, default: 0
      t.date :due_date, null: false

      t.references :team, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :projects, %i[project_name creator_id], unique: true
  end
end
