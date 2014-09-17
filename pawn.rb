require_relative 'piece'
# require 'debugger'

class Pawn < Piece

  attr_accessor :max_dist, :delta
  def initialize(color)
    super
    @name = (color == :b ? "♟" : "♙")
    @max_dist = 2

    @delta = color == :w ? [[2,0], [1,0], [1,-1], [1,1]] : [[-2,0], [-1,0], [-1,-1], [-1,1]]
  end

  def valid_moves?(start_pos,goal_pos,board)
    # debugger
    # if start_pos[0] == 6 || start_pos[0] == 1
  #     self.delta = temp_delta
  #   else
  #     self.delta = temp_delta[1,-1]
  #   end

    return false if out_of_bound?(goal_pos)
    return false if !delta_valid?(start_pos,goal_pos)
    dydx = [goal_pos[0]-start_pos[0], goal_pos[1]-start_pos[1]]
    return false if dydx == self.delta.first && (start_pos.first != 6 && start_pos.first != 1)

    if (start_pos[1] - goal_pos[1]) != 0
      return false if empty?(goal_pos, board)
      return false if board[goal_pos].color == self.color
    else
      return false if !empty?(goal_pos, board)
    end


    true
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