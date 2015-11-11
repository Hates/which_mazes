class Cell < ActiveRecord::Base

  has_many :maze_cells
  has_one :maze, through: :maze_cells

end
