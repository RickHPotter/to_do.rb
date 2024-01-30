# frozen_string_literal: true

# Category Migration
class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :category_name, null: false
      t.text :description

      t.references :team, null: false, foreign_key: true

      t.timestamps
    end

    add_index :categories, %i[category_name team_id], unique: true
  end
end
