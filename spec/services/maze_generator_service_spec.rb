require 'rails_helper'

RSpec.describe MazeGeneratorService do

  let(:width) { 10 }
  let(:height) { 10 }

  let(:maze_generator) { MazeGenerators::Dummy }
  subject { MazeGeneratorService.new(width, height, maze_generator) }

  describe "#generate" do

    it "returns a maze" do
      maze = subject.generate

      expect(maze).to be_instance_of(Maze)
    end

    it "returns a maze of the correct width" do
      maze = subject.generate

      expect(maze.width).to equal(width)
    end

    it "returns a maze of the correct height" do
      maze = subject.generate

      expect(maze.height).to equal(height)
    end

  end

end
