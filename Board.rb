# frozen_string_literal: true

# Board class
class Board
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @matrix = []
    @rows.times do
      new_row = []
      @columns.times do
        new_row.push(Cell.new)
      end
      @matrix.push(new_row)
    end
  end

  def show
    @rows.times { |x| print "#{x} "}
    @rows.times do |x|
      print "#{x} "
      @columns.times do |y|
        case @matrix[x][y].type
        end
      end
    end
  end
end