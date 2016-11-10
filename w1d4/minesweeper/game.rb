require_relative 'board'

class Minesweeper
	def initialize(size = 9, num_bombs = 10)
		@board = Board.new(size, num_bombs)
	end

	def get_pos
		puts 'Please enter a position:'
		print '>> '

		begin
			pos = parse_pos(gets.chomp)
		rescue StandardError => e
			puts e.message + '. Please enter a valid position:'
			print '>> '
			pos = nil
			retry
		end

		pos
	end

	def get_val
		puts 'Please enter a value ("f" to flag, "r" to reveal):'
		print '>> '

		begin
			val = parse_val(gets.chomp)
		rescue StandardError => e
			puts e.message + '. Please enter a valid value ("r" or "f"):'
			print '>> '
			val = nil
			retry
		end

		val
	end

	def parse_pos(str)
		pos = str.split(" ").map(&:to_i)
		raise 'Invalid position' unless pos.length == 2 &&
			pos.all?{|num| num.between?(0, @board.size - 1)}
		pos
	end

	def parse_val(str)
		raise 'Invalid value' unless str =~ /[rf]/
		str
	end

	def play
		until @board.won? || @board.lost?
			system('clear')
			@board.render
			pos = get_pos
			val = get_val
			@board.update(pos, val)
		end

		if @board.won?
			@board.reveal_all!
			@board.render
			puts 'Congratulations yay!!!!'
		else
			puts 'Awwwww :('
		end
	end

end

m = Minesweeper.new(9, 5)
m.play
