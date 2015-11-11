class MazeGeneratorService

  attr_accessor :generator

  def initialize(width, height, generator = MazeGenerators::RecursiveBacktracker)
    @generator = generator.new(width, height)
  end

  def generate
    @generator.generate
  end

end
