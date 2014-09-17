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

  attr_accessor :grid, :is_check_mate

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
    self.draw
    @is_check_mate = false
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
    return nil if self[start_pos].nil?
    if self[start_pos].valid_moves?(start_pos, goal_pos, self)

      if is_check?(start_pos,goal_pos)
        puts "#{self[start_pos].color.to_s} is in check!"
         if is_checkmate?(start_pos, goal_pos)
           puts "checkmate!"
           is_check_mate = true
           return is_check_mate
         end
      else
        self[start_pos], self[goal_pos] = nil, self[start_pos]
      end
    end

  end


  def draw

    board_edge = Array.new(9, "+").join('---')
    board_edge_letters = (0..7).to_a.join('   ')
    board_edge_letters = "    #{board_edge_letters}"

    # arr = get_opponents_moves(:b)

    puts board_edge_letters
    puts  "  #{board_edge} "
    grid.each_with_index do |row, i|
      row = row.map.with_index do |ele, j|
        ele.nil? ? " " : ele.name

        # if arr.include?([i,j])
       #    ele.nil? ? "X" : "K"
       #  elsif ele.nil?
       #    " "
       #  else
       #    ele.name
       #  end
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
        unless  self[[y,x]].nil? || self[[y,x]].color == current_color
          arr.concat(self[[y,x]].all_pos_moves([y,x],self))
        end
      end
    end
    arr
  end

  def is_check?(start_pos,goal_pos)
    current_color = self[start_pos].color
    future_board = dup_board
    future_board.future_move(start_pos,goal_pos)

    all_opponent_moves = future_board.get_opponents_moves(current_color)

    all_opponent_moves.any? do |pos|
      future_board[pos].is_a?(King)

    end
  end

  def is_checkmate?(start_pos, goal_pos)
    return false unless is_check?(start_pos, goal_pos)

    current_color = self[start_pos].color
    king_pos = find_king(current_color)

    king_moves = self[king_pos].all_pos_moves(king_pos, self)
    opponents_moves = get_opponents_moves(current_color)

    (king_moves-opponents_moves).empty?
  end

  def find_king(color)
    8.times do |i|
      8.times do |j|
        return [i,j] if self[[i,j]].color == color && self[[i,j]].is_a?(King)
      end
    end
  end

  #private


  def dup_board
    future_board = Board.new
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

  def future_move(start_pos,goal_pos)
    self[start_pos], self[goal_pos] = nil, self[start_pos]
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new

end
