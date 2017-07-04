require_relative "sudoku/extract"
require_relative "valid_sudoku/collection"
class Validator
  include ValidSudoku::Collection

  attr_reader :extractor, :rows, :columns, :sub_groups

  VALID_RESPONSE = "This sudoku is valid.".freeze
  VALID_INCOMPLETE_RESPONSE = "This sudoku is valid, but incomplete.".freeze
  INVALID_RESPONSE = "This sudoku is invalid.".freeze

  def initialize(puzzle_string)
    @extractor = Sudoku::Extract.new(puzzle_string)
    @rows = extractor.rows
    @columns = extractor.columns
    @sub_groups = extractor.sub_groups
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    if valid?
      complete? ? VALID_RESPONSE : VALID_INCOMPLETE_RESPONSE
    else
      INVALID_RESPONSE
    end
  end

  private

  def valid?
    [rows, columns, sub_groups].all? { |collection| valid_collection?(collection) }
  end

  def valid_collection?(collection)
    collection.all? { |col| super(col) }
  end

  def complete?
    super(extractor.cleaned_sudoku.join(" ").split)
  end
end
