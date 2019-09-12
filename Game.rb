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
    puts 'First, let\'s get the size of the board.'
    print 'Number of rows: '
    rows = gets.chomp.to_i
    print 'Number of columns: '
    columns = gets.chomp.to_i
    @board = Board.new(rows, columns)
    turn
  end

  def turn
    system('clear') || system('cls')
    @board.show
    puts 'What would you like to do next?'
    print '(s) step, (m) mark/unmark, (q) quit: '
    choice = gets.chomp
    case choice
    when 'q'
      quit
    when 'm'
      mark_cell
    when 's'
      step_on_cell
    else
      puts 'Sorry, try again'
      sleep 1
      turn
    end
  end

  def quit
    puts 'Goodbye!'
    exit
  end

  def mark_cell
    puts "Mark"
    x, y = get_coords
    @board.matrix[x][y].mark
    turn
  end

  def step_on_cell
    puts "step"
    x, y = get_coords
    @board.matrix[x][y].step
    turn
  end

  def get_coords
    print "Which row (0-#{@board.rows - 1}): "
    x = gets.chomp.to_i
    print "Which column (0-#{@board.columns - 1}): "
    y = gets.chomp.to_i
    [x, y]
  end

  def end_game
  end
end