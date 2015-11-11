class Maze < ActiveRecord::Base

  has_many :cells

  # Create empty grid of cells for future use.
  def generate_base_cells
    width.times do |x|
      height.times do |y|
        cells.build x: x, y: y
      end
    end

    save!
  end

  def columns
    cells.group_by(&:x)
  end

  def rows
    cells.group_by(&:y)
  end

  def cell_at(x, y)
    cells.detect { |c| c.x == x && c.y == y }
  end

  def neighbours(x, y)
    cell_at(x,y).neighbours
  end

end
