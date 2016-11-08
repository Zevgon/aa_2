require_relative 'card.rb'

class Board
	def initialize(size = 4)
		@size = size
		@grid = []
		populate
	end

	def populate
		square = @size ** 2
		half = square / 2
		nums = (1..half).to_a.concat((1..half).to_a)
		nums.map!{|num| Card.new(num)}
		@grid = nums.each_slice(@size).to_a
	end

	def render
		puts ' _' * @size
		@grid.each do |row|
			row.each do |card|
				card.to_s
			end
			print '|'
			puts
		end
		puts
	end

	def won?
		@grid.flatten.all?{|card| card.hidden == false}
	end

	def reveal!(pos)
		@grid[pos[0]][pos[1]].reveal!
	end

	def hide!(pos)
		@grid[pos[0]][pos[1]].hide!
	end

	def [](pos)
		i, j = pos
		@grid[i][j]
	end
end
