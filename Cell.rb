# frozen_string_literal: true

# Cell class
class Cell
  attr_reader :type
  attr_accessor :hidden, :marked
  
  def initialize
    @type = create_type
    @marked = false
    @hidden = true
  end

  def create_type
    Random.rand(0..1) <= 0.15 ? 'mine' : 'empty'
  end

  def mark
    @marked = !@marked
  end

  def show
    @hidden = false
  end

  def step
    case @type
    when 'mine'
      Game.end
    when 'empty'
      Board.clear
    end
  end
end