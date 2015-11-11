class MazeSolverService

  attr_accessor :maze, :solver

  def initialize(maze, solver = MazeSolvers::WallFollower)
    @maze = maze
    @solver = solver.new(maze)
  end

  def solve
    @solver.solve
  end

  def steps
    @solver.steps
  end

end
