require_relative 'sliding_piece'

class Bishop < SlidingPiece

  def initialize(color)
     super(color)
       @name = (color == :b ? "♝" : "♗")
     @dir = [:d]
  end

end