require_relative 'sliding_piece'

class Rook < SlidingPiece

  def initialize(color)
     super(color)
       @name = (color == :b ? "♜" : "♖")
     @dir = [:h,:v]
  end

end