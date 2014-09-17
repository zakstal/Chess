require_relative 'piece'

class SteppingPiece < Piece

  attr_accessor :delta

  def valid_moves?(start_pos, goal_pos, board)
     return false if out_of_bound?(goal_pos)
     return false unless delta_valid?(start_pos,goal_pos)
     super
  end

  def delta_valid?(start_pos,goal_pos)
    get_delta(start_pos).include?(goal_pos)
  end

  def get_delta(start_pos)
    self.delta.map{|delt| [delt[0] + start_pos[0], delt[1] + start_pos[1]] }
  end

  def all_pos_moves(start_pos,board)
    get_delta(start_pos).select{|goal_pos| valid_moves?(start_pos,goal_pos,board)}
  end
end
