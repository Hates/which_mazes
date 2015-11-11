module MazeGenerators
  class RandomisedKruskals < Base

  # From: https://en.wikipedia.org/wiki/Maze_generation_algorithm#Randomized_Kruskal.27s_algorithm
  #
  # Create a list of all walls, and create a set for each cell, each containing just that one cell.
  # For each wall, in some random order:
  #   If the cells divided by this wall belong to distinct sets:
  #     Remove the current wall.
  #     Join the sets of the formerly divided cells.
  def generate
    @maze
  end

end
