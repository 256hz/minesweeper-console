# frozen_string_literal: true

require_relative './Board.rb'
require_relative './Cell.rb'

# REPL class
class Game
  def initialize
    @board = nil
    start
  end

  def start
    puts 'Welcome to Console Minesweeper!'
    # puts 'First, let\'s get the size of the board.'
    # print 'Number of rows: '
    # rows = gets.chomp.to_i
    # print 'Number of columns: '
    # columns = gets.chomp.to_i
    # @board = Board.new(rows, columns)
    @board = Board.new
    turn
  end

  def turn
    win?
    system('clear') || system('cls')
    @board.show
    puts 'What would you like to do next?'
    print '(s) step, (m) mark/unmark, (q) quit: '
    choice = gets.chomp
    case choice
    when 'q'
      quit
    when 'm'
      mark
    when 's'
      step
    else
      puts 'Sorry, try again'
      sleep 1
      turn
    end
  end

  def win?
    win_game if @board.win?
  end

  def quit
    puts 'Goodbye!'
    exit
  end

  def mark
    puts 'Mark'
    x, y = input_coords
    @board.matrix[x][y].mark
    turn
  end

  def step
    puts 'Step'
    x, y = input_coords
    result = @board.matrix[x][y].step
    lose_game if result == 'mine'
    @board.clear(x, y, {})
    turn
  end

  def input_coords
    max_row = @board.rows - 1
    max_col = @board.columns - 1
    print "Row (0-#{max_row}): "
    x = gets.chomp.to_i
    print "Column (0-#{max_col}): "
    y = gets.chomp.to_i
    if x > max_row || y > max_col
      puts 'Out of range or bad input'
      sleep(1)
      input_coords
    end
    [x, y]
  end

  def lose_game
    system('clear') || system('cls')
    @board.show
    puts 'You stepped on a mine!'
    exit
  end

  def win_game
    system('clear') || system('cls')
    @board.show
    puts 'You won!'
    exit
  end
end
