module MazeGenerators
  class RecursiveBacktracker < Base

    DIRECTIONS = [:north, :south, :east, :west]

    attr_accessor :visited_cells, :stack

    def after_initialize
      @visited_cells = []
      @stack = []
    end

    # From: https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker
    #
    # Make the initial cell the current cell and mark it as visited
    #   While there are unvisited cells
    #     If the current cell has any neighbours which have not been visited
    #       Choose randomly one of the unvisited neighbours
    #       Push the current cell to the stack
    #       Remove the wall between the current cell and the chosen cell
    #       Make the chosen cell the current cell and mark it as visited
    #     Else if stack is not empty
    #       Pop a cell from the stack
    #       Make it the current cell
    #
    def generate
      carve maze.cell_at(0,0)
      maze
    end

    def carve(cell)
      if(visited?(cell))
        return if @stack.empty?
        return carve(@stack.pop)
      end

      @stack.push(cell)

      add_to_visited(cell)
      random_directions.each do |direction|
        visit_direction cell, direction
      end
    end

    def visit_direction(cell, direction)
      neighbour = cell.neighbours.send(direction)
      return if neighbour.nil? || visited?(neighbour)

      remove_walls(cell, neighbour, direction)
      carve(neighbour)
    end

    def remove_walls(cell, neighbour, direction)
      cell.remove_wall(direction)
      neighbour.remove_opposite_wall(direction)
    end

    def add_to_visited(cell)
      @visited_cells << cell
    end

    def visited?(cell)
      @visited_cells.include?(cell)
    end

    def random_directions
      DIRECTIONS.shuffle
    end

  end
end
