require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    childs = node.children
    childs.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    non_losing_move = childs.reject { |child| child.losing_node?(mark) }.sample
    non_losing_move.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
