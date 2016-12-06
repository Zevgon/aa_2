require_relative 'piece'
require_relative 'null_piece'

class Board
	def initialize
		@grid = Array.new(8) {Array.new(8)}
		populate_grid
	end

	def populate_grid
		('0:0'..'1:7').each do |pos|
			i, j = pos.split(':').map(&:to_i)
			next if j > 7
			@grid[i][j] = Piece.new('black', [i, j])
		end

		('2:0'..'5:7').each do |pos|
			i, j = pos.split(':').map(&:to_i)
			next if j > 7
			@grid[i][j] = NullPiece.new(nil, [i, j])
		end

		('6:0'..'7:7').each do |pos|
			i, j = pos.split(':').map(&:to_i)
			next if j > 7
			@grid[i][j] = Piece.new('white', [i, j])
		end
	end

	def render
		puts
		@grid.each do |row|
			puts row.join("") + "|"
		end
		puts
	end
end

b = Board.new
b.render
