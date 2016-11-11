require 'byebug'
require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @current_mark = other_mark(@next_mover_mark)
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.over? && @board.winner && @board.winner != evaluator
    return false if @board.over? && @board.winner == evaluator
    return false if @board.tied?
    return true if children.any?{|child| child.losing_node?(evaluator)}
    return false if children.all?{|child| child.losing_node?(other_mark(evaluator))}
    false
  end

  def winning_node?(evaluator)
    return true if @board.over? && evaluator == @board.winner
    return false if @board.over? && @board.winner && @board.winner != evaluator
    return false if @board.tied?
    return true if @current_mark == evaluator && children.any?{|child| child.winning_node?(@current_mark)}
    return true if @next_mover_mark == evaluator && children.all?{|child| child.winning_node?(@current_mark)}
    false
  end

  def other_mark(mark)
    mark == :x ? :o : :x
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    (0..2).each do |row_idx|
      (0..2).each do |col_idx|
        duped = @board.dup
        unless duped[[row_idx, col_idx]]
          duped[[row_idx, col_idx]] = @next_mover_mark
          result << TicTacToeNode.new(duped, @current_mark, [row_idx, col_idx])
        end
      end
    end

    result
  end
end
