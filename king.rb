require_relative 'stepping_piece'

class King < SteppingPiece


def initialize(name, color)
   super(name, color)
   @delta = [-1,0,1].repeated_permutation(2).to_a - [[0,0]]
end

end