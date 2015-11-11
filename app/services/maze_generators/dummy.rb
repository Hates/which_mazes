module MazeGenerators
  class Dummy < Base

    def generate
      Maze.new width: width, height: height
    end

  end
end
