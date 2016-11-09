require_relative 'board.rb'

class Game
	def initialize(file = './puzzles/almost.txt')
		@board = Board.from_file(file)
	end

	def get_move
		puts 'Please enter a position and a value (space separated):'
		print '>> '
		pos_val = gets.chomp.split(" ").map(&:to_i)
		pos = pos_val[0..1]
		val = pos_val[2]
		@board.update_pos(pos, val)
	end

	def run
		until @board.solved?
			system('clear')
			@board.render
			get_move
		end
	end
end

g = Game.new
g.run
