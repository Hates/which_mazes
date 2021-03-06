module MazeGenerators
  class Base

    attr_accessor :maze

    def initialize(maze)
      @maze = maze
      @maze.update_attribute :generator, self.class

      after_initialize
    end

    def after_initialize
      # Empty stub for sub classes.
    end

  end
end
