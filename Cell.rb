# frozen_string_literal: true

# Cell class
class Cell
  attr_reader :is_mine
  attr_accessor :hidden, :marked, :mines_near

  def initialize
    @is_mine = create_type
    @mines_near = 0
    @marked = false
    @hidden = true
  end

  def create_type
    Random.rand <= 0.2
  end

  def mark
    @marked = !@marked
  end

  def show
    @hidden = false
  end

  def step
    if @is_mine
      Game.end
    else 
      Board.clear
    end
  end
end
