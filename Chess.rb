#!/usr/bin/env ruby
# coding: utf-8

class Piece

  attr_accessor :pos, :name

  def initialize(name = 'k', pos = [])
    @name = name
    @pos = pos
    # @delta = [-1,0,1].repeated_permutation(2).to_a - [[0,0]]
  end

  def move
  end

  def valid_move?
  end

  def out_of_bound?(pos)
    pos.any?{|el| !el.between?(0,7)}
  end
end

class SlidingPiece < Piece

  # def move(pos)
  #   begin
  #     raise if pos.any? {|ele| !ele.between?(0,7)}
  #     @pos = pos
  #  rescue
  #     puts 'out of bound move, try again'
  #     retry
  #   end
  # end

end

class Pawn < Piece

  def valid_moves?(start_pos,goal_pos,board)
    return false if out_of_bound?(goal_pos)
    return false if goal_pos[1] != start_pos[1]
    verticel_moves = goal_pos[0] - start_pos[0]
    puts "*********************"
     Board::SYMBOLS[:wpawn]
 #      #white pawn
      return false if !verticel_moves.between?(1,2)
 #    else
 #      #black pawn
 #      return false if !verticel_moves.between?(-2,-1)
 #    end

    # empty?(goal_pos, board)
    true
  end

  def emtpy?(pos, board)
    board[pos].nil?
  end
end

class SteppingPiece < Piece

end

class Board

  SYMBOLS = {
    :wqueen => "\u{2655}",
    :wking => "\u{2654}",
    :wrook => "♖",
    :wbship => "\u{2657}",
    :wknight => "\u{2658}",
    :wpawn => "\u{2659}",
    :bqueen => "\u{265B}",
    :bking => "\u{265A}",
    :brook => "\u{265C}",
    :bbship => "\u{265D}",
    :bknight => "\u{265E}",
    :bpawn => "\u{265F}"
  }
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8) }
    populate_grid
    self.draw
  end

  def [](pos)
    y,x = pos
    self.grid[y][x]
  end

  def []=(pos, value)
    y,x = pos
    grid[y][x] = value
  end

  def populate_grid
    # self[[0,0]] = "*"
    grid.size.times do |i|
      self[[1,i]] = Pawn.new(SYMBOLS[:wpawn])
      self[[6,i]] = Pawn.new(SYMBOLS[:bpawn])
    end
    self[[0,0]] = SlidingPiece.new(SYMBOLS[:wrook])
    self[[0,2]] = SlidingPiece.new(SYMBOLS[:wbship])
    self[[0,3]] = SlidingPiece.new(SYMBOLS[:wqueen])
    self[[0,5]] = SlidingPiece.new(SYMBOLS[:wbship])
    self[[0,7]] = SlidingPiece.new(SYMBOLS[:wrook])

    self[[7,0]] = SlidingPiece.new(SYMBOLS[:brook])
    self[[7,2]] = SlidingPiece.new(SYMBOLS[:bbship])
    self[[7,3]] = SlidingPiece.new(SYMBOLS[:bqueen])
    self[[7,5]] = SlidingPiece.new(SYMBOLS[:bbship])
    self[[7,7]] = SlidingPiece.new(SYMBOLS[:brook])

    self[[0,1]] = SteppingPiece.new(SYMBOLS[:wknight])
    self[[0,6]] = SteppingPiece.new(SYMBOLS[:wknight])
    self[[0,4]] = SteppingPiece.new(SYMBOLS[:wking])
    self[[7,6]] = SteppingPiece.new(SYMBOLS[:bknight])
    self[[7,1]] = SteppingPiece.new(SYMBOLS[:bknight])
    self[[7,4]] = SteppingPiece.new(SYMBOLS[:bking])
  end

  def move(start_pos, goal_pos)
    #move the piece
    return if self[start_pos].nil?
    if self[start_pos].valid_moves?(start_pos, goal_pos, self)
      self[start_pos], self[goal_pos] = self[goal_pos], self[start_pos]
    end

    self.draw
  end

  def draw

    board_edge = Array.new(9, "+").join('---')
    board_edge_letters = (0..7).to_a.join('   ')
    board_edge_letters = "    #{board_edge_letters}"

    puts board_edge_letters
    puts  "  #{board_edge} "
    grid.each_with_index do |row, i|
      row = row.map do |ele|
        ele.nil? ? " " : ele.name
      end.join(' | ')

      puts "#{i} | #{row} | #{i}"
      puts  "  #{board_edge} "
    end
    puts board_edge_letters
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new


end
