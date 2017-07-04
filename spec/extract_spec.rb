require "spec_helper"
require_relative "../lib/sudoku/extract"

describe Sudoku::Extract do
  let(:sudoku) do
"8 5 0 |0 0 2 |4 0 0
7 2 0 |0 0 0 |0 0 9
0 0 4 |0 0 0 |0 0 0
------+------+------
0 0 0 |1 0 7 |0 0 2
3 0 5 |0 0 0 |9 0 0
0 4 0 |0 0 0 |0 0 0
------+------+------
0 0 0 |0 8 0 |0 7 0
0 1 7 |0 0 0 |0 0 0
0 0 0 |0 3 6 |0 4 0"
  end
  let(:extract) { Sudoku::Extract.new(sudoku) }

  describe "#sub_groups" do
    let(:expected_result) do
      [
        [8, 5, 0, 7, 2, 0, 0, 0, 4],
        [0, 0, 2, 0, 0, 0, 0, 0, 0],
        [4, 0, 0, 0, 0, 9, 0, 0, 0],
        [0, 0, 0, 3, 0, 5, 0, 4, 0],
        [1, 0, 7, 0, 0, 0, 0, 0, 0],
        [0, 0, 2, 9, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 7, 0, 0, 0],
        [0, 8, 0, 0, 0, 0, 0, 3, 6],
        [0, 7, 0, 0, 0, 0, 0, 4, 0],
      ]
    end

    it "returns each sub group in it's own array" do
      extract.sub_groups.each_with_index do |group, index|
        expected_at_index = expected_result[index]
        expect(group).to eq(expected_at_index)
      end
    end
  end

  describe "#rows" do
    let(:expected_result) do
      [
        [8, 5, 0, 0, 0, 2, 4, 0, 0],
        [7, 2, 0, 0, 0, 0, 0, 0, 9],
        [0, 0, 4, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 7, 0, 0, 2],
        [3, 0, 5, 0, 0, 0, 9, 0, 0],
        [0, 4, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 8, 0, 0, 7, 0],
        [0, 1, 7, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 3, 6, 0, 4, 0],
      ]
    end

    it "returns each row in it's own array" do
      expect(extract.rows).to eq(expected_result)
    end
  end

  describe "#columns" do
    let(:expected_result) do
      [
        [8, 7, 0, 0, 3, 0, 0, 0, 0],
        [5, 2, 0, 0, 0, 4, 0, 1, 0],
        [0, 0, 4, 0, 5, 0, 0, 7, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 8, 0, 3],
        [2, 0, 0, 7, 0, 0, 0, 0, 6],
        [4, 0, 0, 0, 9, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 7, 0, 4],
        [0, 9, 0, 2, 0, 0, 0, 0, 0],
      ]
    end
    it "returns each column in it's own array" do
      expect(extract.columns).to eq(expected_result)
    end
  end
end
