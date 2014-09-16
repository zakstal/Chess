require_relative 'piece'
class Pawn < Piece

  def initialize(color)
    super
    @name = (color == :b ? "♟" : "♙")
  end

  def valid_moves?(start_pos,goal_pos,board)
    return false if out_of_bound?(goal_pos)
    return false if goal_pos[1] != start_pos[1]
    verticel_moves = goal_pos[0] - start_pos[0]
    #white pawn
    return false if !verticel_moves.between?(1, 2) if self.color == :w
    #black pawn
    return false if !verticel_moves.between?(-2, -1) if self.color == :b
    super
  end


end