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

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
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
      self[[1,i]] = Pawn.new(:w)
      self[[6,i]] = Pawn.new(:b)
    end
    self[[0,0]] = Rook.new(:w)
    self[[0,2]] = Bishop.new(:w)
    self[[0,3]] = Queen.new(:w)
    self[[0,5]] = Bishop.new(:w)
    self[[0,7]] = Rook.new(:w)

    self[[7,0]] = Rook.new(:b)
    self[[7,2]] = Bishop.new(:b)
    self[[7,3]] = Queen.new(:b)
    self[[7,5]] = Bishop.new(:b)
    self[[7,7]] = Rook.new(:b)

    self[[0,1]] = Knight.new(:w)
    self[[0,6]] = Knight.new(:w)
    self[[0,4]] = King.new(:w)
    self[[7,6]] = Knight.new(:b)
    self[[7,1]] = Knight.new(:b)
    self[[7,4]] = King.new(:b)
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

  def get_opponents_moves(current_color)
    arr = []
    8.times do |y|
      8.times do |x|
        unless self[[y,x]].color == current_color
          arr << self[[y,x]].all_pos_moves([y,x],self)
        end
      end
    end
    arr.uniq
  end

  def is_check?(start_pos,goal_pos)
    current_color = self[start_pos].color
    future_board = dup_board
    future_board.move(start_pos,goal_pos)

    all_opponent_moves = future_board.get_opponents_moves(current_color)

    check_flag = all_opponent_moves.any? do |pos|
      future_board[pos].is_a?(King)
    end

    puts "#{current_color.to_s} is in check!" if check_flag
    check_flag
  end


  #private

  def dup_board
    futrue_board = Board.new
    future_board.grid = deep_dup(self.grid)
    future_board
  end

  def deep_dup(array)
    new_array = []
    array.each do |el|
      new_array << (el.is_a?(Array) ? deep_dup(el) : (el.nil? ? nil : el.dup))
    end
    new_array
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new


end
