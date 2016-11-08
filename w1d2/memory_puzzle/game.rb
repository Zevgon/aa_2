require_relative 'board.rb'

class Game
	def initialize(size = 4)
		@board = Board.new(size)
		@first_guess = nil
		@second_guess = nil
	end

	def play
		system('clear')
		turn_toggle = true
		until @board.won?
			if turn_toggle
				@board.render
				prompt
				position = gets.chomp.split(" ").map(&:to_i)
				@first_guess = position
				@board[position].reveal!
				system('clear')
				@board.render
				turn_toggle = !turn_toggle
			else
				prompt
				position = gets.chomp.split(" ").map(&:to_i)
				@second_guess = position
				card1 = @board[@first_guess]
				card2 = @board[@second_guess]
				card2.reveal!
				system('clear')
				@board.render
				unless card1 == card2
					card1.hide!
					card2.hide!
					puts 'Oops!'
					sleep 2
				end
				system('clear')
				turn_toggle = !turn_toggle
			end
		end
		system('clear')
		puts 'Well done yay!'
		sleep 2
		system('clear')
	end

	def prompt
		puts 'Please enter a position'
		print '>> '
	end
end

g = Game.new(2)
g.play
