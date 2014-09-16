class Piece

  attr_accessor :pos

  def initialize(pos)
    @pos = pos
  end

  def move

  end

end

class SlidingPiece < Piece



end

class SteppingPiece < Piece



end

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    populate_grid
  end

  def [](pos)
    y,x = pos
    grid[y][x]
  end

  def []=(pos,value)
    y,x = pos
    grid[y][x] = value
  end

  def populate_grid
    grid.size.times do |i|
      grid[[0,i]] = Piece.new([0,i])
      grid[[1,i]] = Piece.new([1,i])
      grid[[6,i]] = Piece.new([6,i])
      grid[[7,i]] = Piece.new([7,i])
    end
  end
end
