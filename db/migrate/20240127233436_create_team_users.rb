# frozen_string_literal: true

# Join Table Team <-> User Migration
class CreateTeamUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_users do |t|
      t.boolean :admin, null: false, default: false

      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :team_users, %i[team_id user_id], unique: true
  end
end
