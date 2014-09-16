require_relative 'sliding_piece'

class Rook < SlidingPiece

  def initialize(name, color)
     super(name, color)
     @dir = [:h,:v]
  end

end