#!/usr/bin/env ruby
# coding: utf-8
# %w(piece pawn).each do |file|
#   require_relative file
# end
require_relative 'piece'
require_relative 'pawn'
require_relative 'queen'
require_relative 'bishop'
require_relative 'rook'
require_relative 'king'
require_relative 'knight'

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
      self[[1,i]] = Pawn.new(SYMBOLS[:wpawn],:w)
      # self[[6,i]] = Pawn.new(SYMBOLS[:bpawn],:b)
    end
    self[[0,0]] = Rook.new(SYMBOLS[:wrook],:w)
    self[[0,2]] = Bishop.new(SYMBOLS[:wbship],:w)
    self[[0,3]] = Queen.new(SYMBOLS[:wqueen],:w)
    self[[0,5]] = Bishop.new(SYMBOLS[:wbship],:w)
    self[[0,7]] = Rook.new(SYMBOLS[:wrook],:w)

    self[[7,0]] = Rook.new(SYMBOLS[:brook],:b)
    self[[7,2]] = Bishop.new(SYMBOLS[:bbship],:b)
    self[[7,3]] = Queen.new(SYMBOLS[:bqueen],:b)
    self[[7,5]] = Bishop.new(SYMBOLS[:bbship],:b)
    self[[7,7]] = Rook.new(SYMBOLS[:brook],:b)

    self[[0,1]] = Knight.new(SYMBOLS[:wknight],:w)
    self[[0,6]] = Knight.new(SYMBOLS[:wknight],:w)
    self[[0,4]] = King.new(SYMBOLS[:wking],:w)
    self[[7,6]] = Knight.new(SYMBOLS[:bknight],:b)
    self[[7,1]] = Knight.new(SYMBOLS[:bknight],:b)
    self[[7,4]] = King.new(SYMBOLS[:bking],:b)
  end

  def move(start_pos, goal_pos)
    #move the piece
    return if self[start_pos].nil?
    if self[start_pos].valid_moves?(start_pos, goal_pos, self)
      self[start_pos], self[goal_pos] = nil, self[start_pos]
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
