class CreateMazeCells < ActiveRecord::Migration
  def change
    create_table :maze_cells do |t|
      t.references :maze
      t.references :cell
      t.integer :x
      t.integer :y
      t.starting_cell :boolean, default: false
      t.ending_cell :boolean, default: false
    end
  end
end
