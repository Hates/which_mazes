require 'ostruct'

class Cell < ActiveRecord::Base

  OPPOSITES = { north: :south, south: :north, east: :west, west: :east }

  belongs_to :maze

  def remove_wall(direction)
    update_attribute "carved_#{direction}".to_sym, true
  end

  def remove_opposite_wall(direction)
    update_attribute "carved_#{OPPOSITES[direction]}".to_sym, true
  end

  def neighbours
    north_cell = y > 0 ? maze.cell_at(x, y - 1) : nil
    south_cell = y < (maze.height - 1) ? maze.cell_at(x, y + 1) : nil
    east_cell = x < (maze.width - 1) ? maze.cell_at(x + 1, y) : nil
    west_cell = x > 0 ? maze.cell_at(x - 1, y) : nil

    OpenStruct.new(north: north_cell, south: south_cell, east: east_cell, west: west_cell)
  end

end
