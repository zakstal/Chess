require_relative 'stepping_piece'

class Knight < SteppingPiece

def initialize(name, color)
   super(name, color)
   @delta = []
end

end