require_relative 'sliding_piece'

class Bishop < SlidingPiece

  def initialize(name, color)
     super(name, color)
     @dir = [:d]
  end

end