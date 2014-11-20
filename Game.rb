require_relative 'Chess'

class Game
  attr_accessor :board, :turn

  def initialize
    @board = Board.new
    @turn = [:w,:b].cycle
  end

  def play

    until won?
      current_turn = turn.next
      puts "\e[H\e[2J"
      puts "It's #{current_turn} player\'s turn"
      board.draw
      make_move(current_turn)
    end
  end

  def won?
    board.is_check_mate
  end

  def get_move
    puts "please enter input:"
    input = gets.chomp
    m = /(\d).*(\w).*(\d).*(\w)/
    match = m.match(input).to_a
    p match
    puts matches = formatt_inputs(match[1..-1])
    [matches[0..1], matches[2..3]]
  end

  def formatt_inputs(matches)
    puts "here"
      arr = []
     matches.each_with_index do |el, i|
      if i == 0 || i == 2
        arr << el.to_i
      else
        arr << el.ord - 97
      end
    end
    arr
  end

  def make_move(current_color)
    begin
      start_pos, goal_pos = get_move
      p current_color
      p pos_color = board[start_pos].color

      raise if pos_color != current_color

    rescue
       puts "it's not your turn yet!"
       retry
    end

    step = board.move(start_pos, goal_pos)

    turn.next if step.nil?
    board.is_check_mate = step if step == true
  end


end
if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
# pawn only attack to the side and only one forward move
# check/checkmate
# user interface
