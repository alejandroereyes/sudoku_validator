## Sudoku Validator

[Sudoku](https://en.wikipedia.org/wiki/Sudoku) is a logic-based combinatorial number-placement puzzle. The objective is to fill a 9×9 grid with digits so that each column, each row, and each of the nine 3×3 sub-grids that compose the grid contains all of the digits from 1 to 9.

This exercise was taken from [upcase.com](https://thoughtbot.com/upcase). [`Validator`](https://github.com/alejandroereyes/sudoku_validator/blob/master/lib/validator.rb) takes a representation of a sudoku grid as a string and validates whether or not the grid is valid, valid but incomplete, or invalid. A sudoku grid is valid if:
  - It has no duplicates in a row.
  - It has no duplicates in a column.
  - It has no duplicates in sub-group(one of the smaller 3x3 grids).

`0` represents an empty spot. An example of a grid below.

```
8 5 0 |0 0 2 |4 0 0
7 2 0 |0 0 0 |0 0 9
0 0 4 |0 0 0 |0 0 0
------+------+------
0 0 0 |1 0 7 |0 0 2
3 0 5 |0 0 0 |9 0 0
0 4 0 |0 0 0 |0 0 0
------+------+------
0 0 0 |0 8 0 |0 7 0
0 1 7 |0 0 0 |0 0 0
0 0 0 |0 3 6 |0 4 0
```
To set up locally
```
git clone https://github.com/alejandroereyes/sudoku_validator.git
cd sudoku-validator
bin/setup
```

To run tests
```
bundle exec rspec spec
```

I broke out a module, [`ValidSudoku::Collection`](https://github.com/alejandroereyes/sudoku_validator/blob/master/lib/valid_sudoku/collection.rb) as the meat and potatoes for validation logic. I also broke out the [`Sudoku::Extract`](https://github.com/alejandroereyes/sudoku_validator/blob/master/lib/sudoku/extract.rb) class to take in the sudoku grid string and convert it into collections representing rows, columns, and sub-groups. I added tests for these and the integration specs cover the complete logic executed by the validator.
