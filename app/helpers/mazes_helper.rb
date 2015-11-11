module MazesHelper

  def solve(maze)
    solver = MazeSolverService.new(maze)
    solver.solve
    solver.steps
  end

  def pretty_print_maze(maze)
    output =  "&nbsp;" + "_" * (maze.width * 2 - 1)
    output << "<br>"
    maze.height.times do |y|
      output << "|"
      maze.width.times do |x|
        output << (maze.cell_at(x,y).carved_south? ? "&nbsp;" : "_")
        output << (maze.cell_at(x,y).carved_east? ? "&nbsp;" : "|")
      end

      output << "<br>"
    end

    output
  end

end
