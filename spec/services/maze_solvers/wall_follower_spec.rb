require 'rails_helper'

RSpec.describe MazeSolvers::WallFollower do

  let(:maze) { create :maze }
  let(:cell) { build :cell }

  subject { MazeSolvers::WallFollower.new(maze) }

  describe "solve" do

    it "solves a maze" do
      new_maze = Maze.create width: 10, height: 10
      new_maze.generate_base_cells

      MazeGenerators::RecursiveBacktracker.new(new_maze).generate

      solver = MazeSolvers::WallFollower.new(new_maze)
      solver.solve

      expect(solver.steps.last).to be_ending_cell
    end

  end

  describe "#traverse" do

    it "does nothing if already at the last cell" do
      cell.ending_cell = true
      subject.steps.push cell

      expect(subject).not_to receive(:wall_right?)

      subject.traverse(cell)
    end

    it "turns right and moves forward if there is no wall on the right" do
      subject.steps.push cell

      expect(subject).to receive(:at_end?).once.and_call_original
      expect(subject).to receive(:at_end?).once.and_return(true)

      expect(subject).to receive(:wall_right?).and_return(false)
      expect(subject).to receive(:turn_right)
      expect(subject).to receive(:move_forward).with(cell)

      subject.traverse(cell)
    end

    it "moves forward if there is no wall in front" do
      subject.steps.push cell

      expect(subject).to receive(:at_end?).once.and_call_original
      expect(subject).to receive(:at_end?).once.and_return(true)

      expect(subject).to receive(:wall_right?).and_return(true)
      expect(subject).to receive(:wall_forwards?).and_return(false)
      expect(subject).to receive(:move_forward).with(cell)

      subject.traverse(cell)
    end

    it "turns left" do
      subject.steps.push cell

      expect(subject).to receive(:at_end?).once.and_call_original
      expect(subject).to receive(:at_end?).once.and_return(true)

      expect(subject).to receive(:wall_right?).and_return(true)
      expect(subject).to receive(:wall_forwards?).and_return(true)
      expect(subject).to receive(:turn_left)

      subject.traverse(cell)
    end

  end

  describe "#turn_right" do

    it "turns north" do
      subject.current_direction = :west

      expect {
        subject.turn_right
      }.to change { subject.current_direction }.from(:west).to(:north)
    end

    it "turns south" do
      subject.current_direction = :east

      expect {
        subject.turn_right
      }.to change { subject.current_direction }.from(:east).to(:south)
    end

    it "turns east" do
      subject.current_direction = :north

      expect {
        subject.turn_right
      }.to change { subject.current_direction }.from(:north).to(:east)
    end

    it "turns west" do
      subject.current_direction = :south

      expect {
        subject.turn_right
      }.to change { subject.current_direction }.from(:south).to(:west)
    end

  end

  describe "#turn_left" do

    it "turns north" do
      subject.current_direction = :east

      expect {
        subject.turn_left
      }.to change { subject.current_direction }.from(:east).to(:north)
    end

    it "turns south" do
      subject.current_direction = :west

      expect {
        subject.turn_left
      }.to change { subject.current_direction }.from(:west).to(:south)
    end

    it "turns east" do
      subject.current_direction = :south

      expect {
        subject.turn_left
      }.to change { subject.current_direction }.from(:south).to(:east)
    end

    it "turns west" do
      subject.current_direction = :north

      expect {
        subject.turn_left
      }.to change { subject.current_direction }.from(:north).to(:west)
    end

  end

  describe "move_forward" do

    before { maze.generate_base_cells }

    it "moves north" do
      subject.current_direction = :north

      subject.move_forward(maze.cell_at(0,1))
      expect(subject.steps.last).to eq(maze.cell_at(0,0))
    end

    it "moves south" do
      subject.current_direction = :south

      subject.move_forward(maze.cell_at(0,0))
      expect(subject.steps.last).to eq(maze.cell_at(0,1))
    end

    it "moves east" do
      subject.current_direction = :east

      subject.move_forward(maze.cell_at(0,0))
      expect(subject.steps.last).to eq(maze.cell_at(1,0))
    end

    it "moves west" do
      subject.current_direction = :west

      subject.move_forward(maze.cell_at(1,0))
      expect(subject.steps.last).to eq(maze.cell_at(0,0))
    end

  end

  describe "#wall_right?" do

    it "returns true if there is a wall on the right" do
      subject.current_direction = :east
      cell.carved_south = false

      expect(subject.wall_right?(cell)).to be_truthy
    end

    it "returns false if there is not a wall on the right" do
      subject.current_direction = :east
      cell.carved_south = true

      expect(subject.wall_right?(cell)).to be_falsey
    end

  end

  describe "#wall_forwards?" do

    it "returns true if there is a wall in front" do
      subject.current_direction = :east
      cell.carved_east = false

      expect(subject.wall_forwards?(cell)).to be_truthy
    end

    it "returns false if there is not a wall in front" do
      subject.current_direction = :east
      cell.carved_east = true

      expect(subject.wall_forwards?(cell)).to be_falsey
    end

  end

  describe "#at_end?" do

    it "returns true if the cell is the end cell" do
      cell.ending_cell = true

      expect(subject.at_end?(cell)).to be_truthy
    end

    it "returns false if the cell is not the end cell" do
      cell.ending_cell = false

      expect(subject.at_end?(cell)).to be_falsey
    end

  end

end
