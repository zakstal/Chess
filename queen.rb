require_relative 'sliding_piece'

class Queen < SlidingPiece

  def initialize(color)
     super(color)
       @name = (color == :b ? "♛" : "♕")
     @dir = [:v,:d,:h]
  end

end