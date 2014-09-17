require_relative 'piece'

class SlidingPiece < Piece

  attr_accessor :dir

  def valid_moves?(start_pos, goal_pos, board)
     return false if out_of_bound?(goal_pos)
     return false unless direction_check?(start_pos, goal_pos, self.dir)
     return false unless path_clear?(start_pos,goal_pos,board)
     super
  end

  def direction_check?(start_pos, goal_pos, directions)
    #dir = :v, :h, :d
    # a = [1,2,3,4]
#     p a.select do |el| el % 2 == 0 end
#

    directions.any? { |dir|

      case dir
      when :v
         start_pos[1] == goal_pos[1]
      when :h
         start_pos[0] == goal_pos[0]
      when :d
        delta_x = start_pos[0]-goal_pos[0]
        delta_y = start_pos[1]-goal_pos[1]
        delta_x.abs ==  delta_y.abs
      end
    }
  end

  def path_clear?(start_pos,goal_pos,board)
    arr = [start_pos]
    x_delta = goal_pos[1] <=> start_pos[1]
    y_delta = goal_pos[0] <=> start_pos[0]

    until arr.last == goal_pos
      arr << [arr.last[0]+y_delta, arr.last[1]+x_delta]
    end
    arr -= [start_pos, goal_pos]

    arr.all? {|pos| board[pos].nil?}
  end



  def all_pos_moves(start_pos,board)
    all_moves = (0..7).to_a.repeated_permutation(2).to_a
    all_moves.select{|goal_pos| valid_moves?(start_pos,goal_pos,board)}
  end
end