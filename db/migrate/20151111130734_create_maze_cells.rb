class CreateMazeCells < ActiveRecord::Migration
  def change
    create_table :maze_cells do |t|
      t.references :maze
      t.references :cell
      t.integer :x
      t.integer :y
      t.boolean :starting_cell, default: false
      t.boolean :ending_cell, default: false
    end
  end
end
