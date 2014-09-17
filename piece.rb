class Piece

  attr_accessor  :name, :color

  def initialize(color)
    @color = color
    @name = ''
  end

  def move
    raise NotImplementedError
  end

  def valid_moves?(start_pos, goal_pos, board)
     empty?(goal_pos, board) || board[goal_pos].color != self.color

     # !board.is_check?(start_pos,goal_pos)
  end

  def empty?(pos, board)
    board[pos].nil?
  end

  def out_of_bound?(pos)
    pos.any?{|el| !el.between?(0,7)}
  end
end