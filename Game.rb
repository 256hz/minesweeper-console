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
    p @board
  end

  def repl
  end

  def quit
  end

  def mark_cell
  end

  def step_on_cell
  end

  def end_game
  end
end