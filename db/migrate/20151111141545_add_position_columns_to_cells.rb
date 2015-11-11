class AddPositionColumnsToCells < ActiveRecord::Migration
  def change
    add_column :cells, :maze_id, :integer
    add_column :cells, :x, :integer
    add_column :cells, :y, :integer
    add_column :cells, :starting_cell, :boolean, default: false
    add_column :cells, :ending_cell, :boolean, default: false
  end
end
