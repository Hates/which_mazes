require 'rails_helper'

RSpec.describe Maze, type: :model do

  let(:width) { 10 }
  let(:height) { 10 }

  subject { Maze.new width: width, height: height }

  describe "#generate_base_cells" do

    it "generates the right number of cells" do
      subject.generate_base_cells

      expect(subject.cells.size).to equal(width * height)
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

end
