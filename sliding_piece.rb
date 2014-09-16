require_relative 'piece'

class SlidingPiece < Piece

  attr_accessor :dir
  # def initialize(name, color)
#     super(name, color)
#   end

  def valid_moves?(start_pos, goal_pos, board)
     return false if out_of_bound?(goal_pos)
     return false unless direction_check?(start_pos, goal_pos, self.dir)
     return false unless path_clear?(start_pos,goal_pos,board)
     super
  end

  def direction_check?(start_pos, goal_pos, directions)
    #dir = :v, :h, :d
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

    ((start_pos[1]...goal_pos[1]).to_a-[start_pos[1]]).each do |x|
      ((start_pos[0]...goal_pos[0]).to_a-[start_pos[0]]).each do |y|
        return false unless board[[y,x]].nil?
      end
    end

    true
  end

end