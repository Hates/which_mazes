class DropMazeCells < ActiveRecord::Migration
  def change
    drop_table :maze_cells
  end
end
