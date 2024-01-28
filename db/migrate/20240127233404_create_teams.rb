# frozen_string_literal: true

# Team Migration
class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :team_name, null: false
      t.text :description
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :policy, null: false, default: 0

      t.timestamps
    end

    add_index :teams, %i[team_name creator_id], unique: true
  end
end
