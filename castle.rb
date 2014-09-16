require_relative 'sliding_piece'

class Castle < SlidingPiece

  def initialize(name, color)
     super(name, color)
     @dir = [:h]
  end

end