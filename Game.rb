require_relative 'Chess'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def won?
    # board[pos].name
  end

  def dup_board
    deep_dup(board.grid)
  end

  def deep_dup(array)
    new_array = []
    array.each do |el|
      new_array << (el.is_a?(Array) ? deep_dup(el) : (el.nil? ? nil : el.dup))
    end
    new_array
  end

end