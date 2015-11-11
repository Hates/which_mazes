module MazeGenerators
  class Base

    attr_accessor :maze

    def initialize(maze)
      @maze = maze
      after_initialize
    end

    def after_initialize
      # Empty stub
    end

  end
end
