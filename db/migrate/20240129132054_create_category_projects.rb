# frozen_string_literal: true

# CategoryProject Migration
class CreateCategoryProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :category_projects do |t|
      t.references :category, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end

    add_index :category_projects, %i[category_id project_id], unique: true
  end
end
