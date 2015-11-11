require 'rails_helper'

RSpec.describe MazeGeneratorService do

  let(:maze_generator) { MazeGenerators::Dummy }
  subject { MazeGeneratorService.new(maze_generator) }

  describe "#generate" do

    it "returns a new Maze" do
      maze = subject.generate

      expect(maze).to be_instance_of(Maze)
    end

  end

end
