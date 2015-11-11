module MazeGenerators
  class RandomisedPrims < Base

  # https://en.wikipedia.org/wiki/Maze_generation_algorithm#Randomized_Prim.27s_algorithm
  #
  # Start with a grid full of walls.
  # Pick a cell, mark it as part of the maze. Add the walls of the cell to the wall list.
  # While there are walls in the list:
  #   Pick a random wall from the list and a random direction. If the cell in that direction isn't in the maze yet:
  #     Make the wall a passage and mark the cell on the opposite side as part of the maze.
  #     Add the neighboring walls of the cell to the wall list.
  #   Remove the wall from the list.
  def generate
    @maze
  end

end
