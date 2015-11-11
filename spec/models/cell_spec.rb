require 'rails_helper'

RSpec.describe Cell, type: :model do

  let(:width) { 10 }
  let(:height) { 10 }
  let(:maze) { build :maze, width: 10, height: 10 }

  let(:cell) { build :cell }

  describe "#remove_wall" do

    it "carves north" do
      expect {
        cell.remove_wall(:north)
      }.to change { cell.carved_north }.to(true)
    end

    it "carves south" do
      expect {
        cell.remove_wall(:south)
      }.to change { cell.carved_south }.to(true)
    end

    it "carves east" do
      expect {
        cell.remove_wall(:east)
      }.to change { cell.carved_east }.to(true)
    end

    it "carves west" do
      expect {
        cell.remove_wall(:west)
      }.to change { cell.carved_west }.to(true)
    end

  end

  describe "#remove_opposite_wall" do

    it "carves north" do
      expect {
        cell.remove_opposite_wall(:south)
      }.to change { cell.carved_north }.to(true)
    end

    it "carves south" do
      expect {
        cell.remove_opposite_wall(:north)
      }.to change { cell.carved_south }.to(true)
    end

    it "carves east" do
      expect {
        cell.remove_opposite_wall(:west)
      }.to change { cell.carved_east }.to(true)
    end

    it "carves west" do
      expect {
        cell.remove_opposite_wall(:east)
      }.to change { cell.carved_west }.to(true)
    end

  end

  describe "neighbours" do

    context "first row" do

      context "first column" do

        it "returns east and south cells" do
          target_cell = Cell.new(x: 0, y: 0)

          north_cell = Cell.new(x: 0, y: -0)
          south_cell = Cell.new(x: 0, y: 1)
          east_cell = Cell.new(x: 1, y: 0)
          west_cell = Cell.new(x: -1, y: 0)

          maze.cells << target_cell
          maze.cells << north_cell
          maze.cells << south_cell
          maze.cells << east_cell
          maze.cells << west_cell

          neighbours = target_cell.neighbours
          expect(neighbours.north).to eq(nil)
          expect(neighbours.south).to eq(south_cell)
          expect(neighbours.east).to eq(east_cell)
          expect(neighbours.west).to eq(nil)
        end

      end

    end

    ### REST CUT OUT FOR BEREVITY.

  end

end
