require_relative 'Chess'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def won?
    # board[pos].name
  end





end

# pawn only attack to the side and only one forward move
# check/checkmate
# user interface
