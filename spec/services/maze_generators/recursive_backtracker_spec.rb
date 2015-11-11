require 'rails_helper'

RSpec.describe MazeGenerators::RecursiveBacktracker do

  let(:maze) { create :maze }
  let(:cell) { build :cell }

  subject { MazeGenerators::RecursiveBacktracker.new(maze) }

  describe "#generate" do

    before { maze.generate_base_cells }

    it "generates a maze with no cells walls uncarved" do
      subject.generate

      maze.cells.each do |cell|
        expect(cell.carved_north || cell.carved_south || cell.carved_east || cell.carved_west).to be_truthy
      end
    end

    it "generates a maze with no cells with every wall carved" do
      subject.generate

      maze.cells.each do |cell|
        expect(cell.carved_north && cell.carved_south && cell.carved_east && cell.carved_west).to be_falsey
      end
    end

    it "returns the maze" do
      expect(subject.generate).to equal(maze)
    end

  end

  describe "#carve" do

    context "with a visited cell" do

      it "returns if the stack is empty" do
        expect(subject).to receive(:carve).once.and_call_original

        subject.add_to_visited(cell)
        subject.carve(cell)
      end

      it "carves the last cell in the stack" do
        second_cell = build :cell

        expect(subject).to receive(:carve).with(cell).and_call_original
        expect(subject).to receive(:carve).with(second_cell).and_return(true)

        subject.stack.push(second_cell)
        subject.add_to_visited(cell)
        subject.add_to_visited(second_cell)
        subject.carve(cell)
      end

    end

    context "with a non visited cell" do

      it "pushes the cell onto the stack" do
        allow(subject).to receive(:visit_direction)

        subject.carve(cell)

        expect(subject.stack).to include(cell)
      end

      it "adds the cell to the visited list" do
        allow(subject).to receive(:visit_direction)

        subject.carve(cell)

        expect(subject.visited_cells).to include(cell)
      end

      it "visits all directions" do
        expect(subject).to receive(:visit_direction).with(cell, :north)
        expect(subject).to receive(:visit_direction).with(cell, :south)
        expect(subject).to receive(:visit_direction).with(cell, :east)
        expect(subject).to receive(:visit_direction).with(cell, :west)

        subject.carve(cell)
      end

    end

  end

  describe "#visit_direction" do

    it "returns if there is no neighbour in the given direction" do
      neighbour_double = double "Neighbour", north: nil
      allow(cell).to receive(:neighbours).and_return(neighbour_double)
      expect(subject).not_to receive(:visited?)

      subject.visit_direction(cell, :north)
    end

    it "returns if there the neighbour has been visited" do
      neighbour_double = double "Neighbour", north: build(:cell)
      allow(cell).to receive(:neighbours).and_return(neighbour_double)
      allow(subject).to receive(:visited?).and_return(true)
      expect(subject).not_to receive(:remove_walls)

      subject.visit_direction(cell, :north)
    end

    it "removes the walls and carves the neighbour" do
      neighbour_double = double "Neighbour", north: build(:cell)
      allow(cell).to receive(:neighbours).and_return(neighbour_double)

      expect(subject).to receive(:remove_walls)
      expect(subject).to receive(:carve).with(neighbour_double.north)

      subject.visit_direction(cell, :north)
    end

  end

  describe "#remove_walls" do

    let(:neighbour) { build :cell }

    it "removes the wall from the cell" do
      expect {
        subject.remove_walls(cell, neighbour, :north)
      }.to change { cell.carved_north }.to(true)
    end

    it "removes the opposite wall from the neighbour" do
      expect {
        subject.remove_walls(cell, neighbour, :north)
      }.to change { neighbour.carved_south }.to(true)
    end

  end

  describe "#add_to_visited" do

    it "adds a cell to the array of visited cells" do

      expect {
        subject.add_to_visited(cell)
      }.to change { subject.visited_cells.size }.by(1)
    end

  end

  describe "#visited?" do

    it "returns true if a cell is in the visited array" do
      subject.visited_cells << cell

      expect(subject.visited?(cell)).to be_truthy
    end

    it "returns false if a cell is not in the visited array" do
      expect(subject.visited?(cell)).to be_falsey
    end

  end

end
