require_relative 'stepping_piece'

class Knight < SteppingPiece

def initialize(color)
   super(color)
     @name = (color == :b ? "♞" : "♘")
   @delta = [
     [-1, -2],
     [-1,  2],
     [ 1, -2],
     [ 1,  2],
     [-2, -1],
     [-2,  1],
     [ 2, -1],
     [ 2,  1]
  ]
end

end