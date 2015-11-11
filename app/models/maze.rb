class Maze < ActiveRecord::Base

  has_many :maze_cells
  has_many :cells, through: :maze_cells

  # Create empty grid of cells for future use.
  def generate_base_cells
    width.times do |x|
      height.times do |y|
        maze_cells << MazeCell.build_cell(self, x, y)
      end
    end

    save!
  end

  def columns
    maze_cells.group_by(&:x)
  end

  def rows
    maze_cells.group_by(&:y)
  end

end
