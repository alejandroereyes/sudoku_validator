module Sudoku
  class Extract
    attr_reader :sudoku

    def initialize(sudoku)
      @sudoku = sudoku
    end

    def rows
      @rows ||= cleaned_sudoku.map { |row| row.split }
    end

    def columns
      index = nil
      @columns  ||= Array.new(rows.size).map do
        index = index.nil? ? 0 : index + 1
        rows.map { |row| row[index] }
      end

      @columns
    end

    def sub_groups
      if @sub_groups.nil?
        @sub_groups = Array.new
        sequence = [[0, -13], [5, -6], [11, -1]]

        3.times do |index|
          sequence.each do |range|
            @sub_groups << extract_sub_group_from(chunked_sudoku[index], range)
          end
        end
      end

      @sub_groups
    end

    def cleaned_sudoku
      if @cleaned_sudoku.nil?
        @cleaned_sudoku = sudoku
        .gsub("|", "")
        .split("------+------+------")
        .join.split("\n")
        .reject(&:empty?)
      end
      @cleaned_sudoku
    end

    private

    def chunked_sudoku
      if @chunked_sudoku.nil?
        @chunked_sudoku = Array.new
        cleaned_sudoku.each_slice(3) { |section| @chunked_sudoku << section }
      end
      @chunked_sudoku
    end

    def extract_sub_group_from(level, range)
      level.map do |section|
        section[range.first..range.last]
      end.join(" ").split
    end
  end
end
