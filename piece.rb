class Piece

  attr_accessor :pos, :name, :color

  def initialize(name, color)
    @color = color
    @name = name
    @pos = pos
    # @delta = [-1,0,1].repeated_permutation(2).to_a - [[0,0]]
  end

  def move
  end

  def valid_move?
     empty?(goal_pos, board) || board[goal_pos].color != self.color
  end

  def empty?(pos, board)
    board[pos].nil?
  end

  def out_of_bound?(pos)
    pos.any?{|el| !el.between?(0,7)}
  end
end