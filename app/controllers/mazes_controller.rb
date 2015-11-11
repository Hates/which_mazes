class MazesController < ApplicationController

  def index
    @mazes = Maze.all.includes(:cells).order(id: :desc)
  end

  def create
    @maze = Maze.create maze_attributes
    @maze.generate_base_cells

    MazeGenerators::RecursiveBacktracker.new(@maze).generate

    flash[:success] = "Maze created!"
    redirect_to root_path
  end

  def destroy
    maze = Maze.find(params[:id])
    maze.destroy

    flash[:success] = "Maze deleted!"
    redirect_to root_path
  end

  private

  def maze_attributes
    params.require(:maze).permit(:width, :height)
  end

end
