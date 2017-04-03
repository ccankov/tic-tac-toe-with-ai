require_relative 'tic_tac_toe'
require 'byebug'

# A polytree node for a Tic Tac Toe game
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return @board.winner != evaluator if @board.winner
    return false if @board.tied?
    childs = children
    if @next_mover_mark != evaluator
      childs.each { |child| return true if child.losing_node?(evaluator) }
      false
    else
      childs.each { |child| return false unless child.losing_node?(evaluator) }
      true
    end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.winner
    return false if @board.tied?
    childs = children
    if @next_mover_mark != evaluator
      childs.each { |child| return false unless child.winning_node?(evaluator) }
      true
    else
      childs.each { |child| return true if child.winning_node?(evaluator) }
      false
    end
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
    next_turn_mark = @next_mover_mark == :o ? :x : :o
    TicTacToeNode.new(possible_board, next_turn_mark, [row_num, col_num])
  end
end
