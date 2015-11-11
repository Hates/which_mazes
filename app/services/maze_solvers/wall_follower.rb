module MazeSolvers
  class WallFollower < Base

    RIGHT_TURNS = {
      north: :east,
      south: :west,
      east: :south,
      west: :north
    }

    LEFT_TURNS = {
      north: :west,
      south: :east,
      east: :north,
      west: :south
    }

    attr_accessor :steps, :current_direction

    def after_initialize
      @steps = []
      @current_direction = :south
    end

    # https://en.wikipedia.org/wiki/Maze_solving_algorithm#Wall_follower
    #
    # If the maze is simply connected, that is, all its walls are connected
    # together or to the maze's outer boundary, then by keeping one hand in
    # contact with one wall of the maze the solver is guaranteed not to get
    # lost and will reach a different exit if there is one; otherwise, he or
    # she will return to the entrance having traversed every corridor next to
    # that connected section of walls at least once.
    def solve
      traverse maze.cell_at(0,0)
      maze
    end

    def traverse(cell)
      steps << cell
      while !at_end?(steps.last)
        current_cell = steps.last

        if !wall_right?(current_cell)
          turn_right
          move_forward(current_cell)
        elsif !wall_forwards?(current_cell)
          move_forward(current_cell)
        else
          turn_left
        end
      end
    end

    def turn_right
      @current_direction = RIGHT_TURNS[@current_direction]
    end

    def turn_left
      @current_direction = LEFT_TURNS[@current_direction]
    end

    def move_forward(cell)
      steps.push cell.neighbours.send(@current_direction)
    end

    def wall_right?(cell)
      !cell.send("carved_#{RIGHT_TURNS[@current_direction]}?".to_sym)
    end

    def wall_forwards?(cell)
      !cell.send("carved_#{@current_direction}?".to_sym)
    end

    def at_end?(cell)
      cell.ending_cell?
    end

  end
end
