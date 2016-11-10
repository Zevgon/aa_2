require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.winner == other_mark(evaluator)
    # return true if children.all?{|child| child.losing_node?(other_mark(@next_mover_mark))}
    false
  end

  def winning_node?(evaluator)
    @board.winner == evaluator
  end

  def other_mark(mark)
    mark == :x ? :o : :x
  end

  def next_next_mover_mark
    @next_mover_mark == :x ? :o : :x
  end

  def get_move_pos(num)
    [num / 3, num % 3]
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    9.times do |idx|
      move_pos = get_move_pos(idx)
      i, j = move_pos
      next if @board[move_pos]
      next_possible_board = Array.new(9)
      next_possible_board[idx] = @next_mover_mark
      next_possible_board = next_possible_board.each_slice(3).to_a
      new_node = TicTacToeNode.new(Board.new(next_possible_board), next_next_mover_mark, move_pos)
      result << new_node
    end

    result
  end
end
