#!/usr/bin/env ruby
#encoding utf-8

#black piece
def draw
  wqueen = "\u{2655}"
  wking = "\u{2654}"
  wrook = "\u{2656}"
  wbship = "\u{2657}"
  wknight = "\u{2658}"
  wpawn = "\u{2659}"

  bqueen = "\u{265B}"
  bking = "\u{265A}"
  brook = "\u{265C}"
  bbship = "\u{265D}"
  bknight = "\u{265E}"
  bpawn = "\u{265F}"

  board = Array.new(8) {Array.new(8, " " ) }
  b_size = board.length

  board_edge = Array.new(9, "+").join('---')

  board_edge_letters = ('a'..'h').to_a.join('   ')
  board_edge_letters = "   #{board_edge_letters}"
  board[0][0] = wrook
  board[0][1] = wknight
  board[0][2] = wbship
  board[0][3] = wqueen
  board[0][4] = wking
  board[0][5] = wbship
  board[0][6] = wknight
  board[0][7] = wrook

  board[7][0] = brook
  board[7][1] = bknight
  board[7][2] = bbship
  board[7][3] = bqueen
  board[7][4] = bking
  board[7][5] = bbship
  board[7][6] = bknight
  board[7][7] = brook
  #draw
  puts board_edge_letters
  puts  "  #{board_edge} "
  board.each_with_index do |row, i|
    row = row.join(' | ')
    puts "#{i+1} | #{row} | #{i+1}"
    puts  "  #{board_edge} "
  end
  puts board_edge_letters

end



if __FILE__ == $PROGRAM_NAME
  #do stuff
  draw
end