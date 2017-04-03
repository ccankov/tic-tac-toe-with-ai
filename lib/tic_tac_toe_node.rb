require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    
  end

  def winning_node?(evaluator)

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, row_num|
      row.each_with_index do |mark, col_num|
        next unless mark.nil?
        children << generate_child(row_num, col_num)
      end
    end
    children
  end

  private

  def generate_child(row_num, col_num)
    possible_board = @board.dup
    possible_board[[row_num, col_num]] = @next_mover_mark
    next_turn_mark = @next_turn_mark == :o ? :x : :o
    TicTacToeNode.new(possible_board, next_turn_mark, [row_num, col_num])
  end
end
