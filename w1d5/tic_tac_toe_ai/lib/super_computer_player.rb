require 'byebug'

require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    t = TicTacToeNode.new(game.board, mark)
    # debugger
    node = t.children.select{|child| child.winning_node?(mark)}[0]
    return node.prev_move_pos if node
    node = t.children.select{|child| !child.losing_node?(mark)}[0]
    return node.prev_move_pos if node
    raise 'Invalid board lol'
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
