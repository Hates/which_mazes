class MazeGeneratorService

  attr_accessor :maze, :generator

  def initialize(maze, generator = MazeGenerators::RecursiveBacktracker)
    @maze = maze
    @generator = generator.new(maze)
  end

  def generate
    @generator.generate
  end

end
