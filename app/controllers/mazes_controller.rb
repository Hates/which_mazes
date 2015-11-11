class MazesController < ApplicationController

  def index
    @mazes = Maze.all.includes(:cells).order(id: :desc)
  end

end
