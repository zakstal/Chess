require_relative 'sliding_piece'

class Queen < SlidingPiece

  def initialize(name, color)
     super(name, color)
     @dir = [:v,:d,:h]
  end

end