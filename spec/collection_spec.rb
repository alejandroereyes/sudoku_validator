require "spec_helper"
require_relative "../lib/valid_sudoku/Collection"
describe ValidSudoku::Collection do
  let(:sudoku_collection) { Object.new.extend ValidSudoku::Collection }

  describe "#valid_collection?" do
    let(:some_collection) { [] }

    context "when size is valid" do
      before { allow(sudoku_collection).to receive(:valid_size?).and_return(true) }

      context "when values are valid" do
        before { allow(sudoku_collection).to receive(:allowed_values?).and_return(true) }

        context "when there are no dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(true) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq true }
        end
        context "when there are dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(false) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq false }
        end
      end
      context "when values are not valid" do
        before { allow(sudoku_collection).to receive(:allowed_values?).and_return(false) }

        context "when there are no dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(true) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq false }
        end
        context "when there are dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(false) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq false }
        end
      end
    end

    context "when size is not valid" do
      before { allow(sudoku_collection).to receive(:valid_size?).and_return(false) }

      context "when values are valid" do
        before { allow(sudoku_collection).to receive(:allowed_values?).and_return(true) }

        context "when there are no dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(true) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq false }
        end
        context "when there are dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(false) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq false }
        end
      end
      context "when values are not valid" do
        before { allow(sudoku_collection).to receive(:allowed_values?).and_return(false) }

        context "when there are no dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(true) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq false }
        end
        context "when there are dups" do
          before { allow(sudoku_collection).to receive(:no_duplicate_values?).and_return(false) }
          let(:subject) { sudoku_collection.valid_collection?(some_collection) }
          it { is_expected.to eq false }
        end
      end
    end
  end

  describe "#valid_size?" do
    context "when size is invalid" do
      let(:arr) { ["1", "2"] }
      let(:subject) { sudoku_collection.valid_size?(arr) }

      it { is_expected.to eq false }
    end
    context "when size is valid" do
      let(:arr) { ["1", "2", "3", "4", "5", "6", "7", "8", "9"] }
      let(:subject) { sudoku_collection.valid_size?(arr) }
      it { is_expected.to eq true }
    end
  end

  describe "#allowed_values?" do
    context "when any value lays outside allowed values" do
      let(:arr) { ["0", "1", "2", "3", "4", "5", "6", "7", "8", "99"] }
      let(:subject) { sudoku_collection.allowed_values?(arr) }
      it { is_expected.to eq false }
    end
    context "when all values lay inside allowed values" do
      let(:arr) { ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] }
      let(:subject) { sudoku_collection.allowed_values?(arr) }
      it { is_expected.to eq true }
    end
  end

  describe "#no_duplicate_values?" do
    context "when contains duplicate values" do
      let(:arr) { ["1", "1", "2"] }
      let(:subject) { sudoku_collection.no_duplicate_values?(arr) }
      it { is_expected.to eq false }
    end
    context "when does not contain any duplicate values" do
      let(:arr) { ["1", "3", "2"] }
      let(:subject) { sudoku_collection.no_duplicate_values?(arr) }
      it { is_expected.to eq true }
    end
    context "when there are multiple null considered values" do
      let(:arr) { ["0", "0", "1", "2", "3"] }
      let(:subject) { sudoku_collection.no_duplicate_values?(arr) }
      it { is_expected.to eq true }
    end
  end

  describe "#complete?" do
    context "when contains incomplete cells" do
      let(:arr) { ["0", "1", "2", "3", "4", "5", "6", "7", "8"] }
      let(:subject) { sudoku_collection.complete?(arr) }
      it { is_expected.to eq false }
    end
    context "when does not contain any incomplete cells" do
      let(:arr) { ["1", "2", "3", "4", "5", "6", "7", "8", "9"] }
      let(:subject) { sudoku_collection.complete?(arr) }
      it { is_expected.to eq true }
    end
  end
end
