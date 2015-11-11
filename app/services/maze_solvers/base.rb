module MazeSolvers
  class Base

    attr_accessor :maze

    def initialize(maze)
      @maze = maze
      after_initialize
    end

    def after_initialize
      # Empty stub for sub classes.
    end

  end
end
