# frozen_string_literal: true

# Board class
class Board
  attr_reader :rows, :columns
  attr_accessor :matrix

  def initialize(rows: 10, columns: 10)
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

  def check_no_diags
    [
                [0, -1], 
      [-1,  0],          [1,  0],
                [0,  1] 
    ]
  end

  def win?
    @matrix.each do |row|
      row.each do |cell|
        return false if cell.hidden && !cell.marked
      end
    end
    true
  end

  def clear(x, y, checked_cells)
    return if @matrix[x][y].is_mine

    check_no_diags.each do |spot|
      next if out_of_bounds(x, y, spot)

      spot_x = x + spot[0]
      spot_y = y + spot[1]
      cell_name = "#{spot_x}_#{spot_y}"

      next if checked_cells[cell_name]

      cell = @matrix[spot_x][spot_y]
      checked_cells[cell_name] = true
      next if cell.is_mine

      cell.hidden = false
      clear(spot_x, spot_y, checked_cells)
    end
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
    print '   '
    @rows.times { |x| print "#{x} " }
    puts
    print '  '
    @rows.times { print '__' }
    puts
    @rows.times do |x|
      print "#{x}| "
      @columns.times do |y|
        cell = @matrix[x][y]
        print cell.hidden ? cell.marked ? '+ ' : '☐ ' : cell.is_mine ? '* ' : "#{cell.mines_near} "
        # print cell.marked ? '+ ' : '☐ ' if cell.hidden
        # print cell.is_mine ? '* ' : "#{cell.mines_near} " unless cell.hidden
      end
      puts
    end
  end
end
