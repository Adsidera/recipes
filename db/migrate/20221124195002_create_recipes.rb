# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.string :ingredients
      t.float :ratings
      t.string :cuisine
      t.string :category
      t.string :author
      t.string :image
      t.tsvector :tsv
      t.index :tsv, using: :gin

      t.timestamps
    end
  end
end
