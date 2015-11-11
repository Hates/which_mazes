class Maze < ActiveRecord::Base

  has_many :maze_cells
  has_many :cells, through: :maze_cells

end
