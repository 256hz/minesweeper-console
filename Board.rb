# frozen_string_literal: true

# Board class
class Board
  attr_reader :rows, :columns
  attr_accessor :matrix

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @matrix = []

    create_rows
    create_counts
  end

  def check
    [
      [-1, -1], [0, -1], [1, -1],
      [-1,  0],          [1,  0],
      [-1,  1], [0,  1], [1,  1]
    ]
  end

  def create_rows
    @rows.times do
      new_row = []
      @columns.times do
        new_row.push(Cell.new)
      end
      @matrix.push(new_row)
    end
  end

  def create_counts
    @rows.times do |x|
      @columns.times do |y|
        cell = @matrix[x][y]
        next if cell.is_mine

        check.each do |spot|
          next if out_of_bounds(x, y, spot)

          check_cell = @matrix[x + spot[0]][y + spot[1]]
          cell.mines_near += 1 if check_cell.is_mine
        end
      end
    end
  end

  def out_of_bounds(x, y, spot)
    (x + spot[0]).negative? || (y + spot[1]).negative? || x + spot[0] >= @rows || y + spot[1] >= @columns
  end

  def show
    print '  '
    @rows.times { |x| print "#{x} " }
    puts ''
    @rows.times do |x|
      print "#{x} "
      @columns.times do |y|
        cell = @matrix[x][y]
        # print cell.is_mine ? '* ' : "#{cell.mines_near} "
        if cell.hidden
          print cell.marked ? '? ' : '☐ '
        elsif !cell.is_mine
          print "#{cell.mines_near} "
        elsif cell.is_mine
          print '* '
        end
      end
      puts ''
    end
  end
end