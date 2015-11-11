require 'rails_helper'

RSpec.describe Maze, type: :model do

  let(:width) { 10 }
  let(:height) { 10 }

  subject { Maze.new width: width, height: height }

  describe "#generate_base_cells" do

    before { subject.generate_base_cells }

    it "generates the right number of cells" do
      expect(subject.cells.size).to equal(width * height)
    end

    it "sets the starting cell" do
      expect(subject.cell_at(0,0)).to be_starting_cell
    end

    it "sets the ending cell" do
      expect(subject.cell_at(width - 1, height - 1)).to be_ending_cell
    end

  end

  describe "#rows" do

    before { subject.generate_base_cells }

    it "has the right number of rows" do
      expect(subject.rows.size).to equal(height)
    end

  end

  describe "#columns" do

    before { subject.generate_base_cells }

    it "has the right number of columns" do
      expect(subject.columns.size).to equal(width)
    end

  end

  describe "#cell_at" do

    before { subject.generate_base_cells }

    it "returns the cell at a given x and y" do
      cell = subject.cell_at(1, 2)

      expect(cell.x).to equal(1)
      expect(cell.y).to equal(2)
    end

  end

  describe "#neighbours" do

    before { subject.generate_base_cells }

    it "returns the neighbours at a given x and y" do
      neighbours = subject.neighbours(1, 1)

      expect(neighbours.north).to equal(subject.cell_at(1, 0))
      expect(neighbours.south).to equal(subject.cell_at(1, 2))
      expect(neighbours.east).to equal(subject.cell_at(2, 1))
      expect(neighbours.west).to equal(subject.cell_at(0, 1))
    end

  end

end
