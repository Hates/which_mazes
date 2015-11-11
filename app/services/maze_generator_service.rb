class MazeGeneratorService

  attr_accessor :generator

  def initialize(generator = MazeGenerators::RecursiveBacktracker)
    @generator = generator.new
  end

  def generate
    @generator.generate
  end

end
