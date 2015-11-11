class MazeCell < ActiveRecord::Base

  belongs_to :maze
  belongs_to :cell

end
