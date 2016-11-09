require_relative 'tile.rb'

class Board
	def initialize(grid)
		@grid = grid
	end

	def self.from_file(path)
		grid = []
		File.readlines(path).each do |line|
			line.chomp!
			row = []
			line.each_char do |char|
				given = char != '0'
				row << Tile.new(char.to_i, given)
			end
			grid << row
		end
		# p grid.map{|el| el.map{|tile| tile.val}}
		Board.new(grid)
	end

	def [](pos)
		i, j = pos
		@grid[i][j]
	end

	def []=(pos, val)
		i, j = pos
		@grid[i][j] = val
	end

	def update_pos(pos, val)
		self[pos] = Tile.new(val) unless self[pos].given
	end

	def render
		puts
		@grid.each do |row|
			row.each do |tile|
				print tile.to_s
			end
			print '|'
			puts
		end
		puts
	end

	def solved?
		return false unless @grid.all?{|row| correct?(row)}
		return false unless @grid.transpose.all?{|column| correct?(column)}
		return false unless boxes.all?{|box| correct?(box)}
		true
	end

	def correct?(tile_arr)
		tile_arr.map{|tile| tile.val}.sort == (1..9).to_a
	end

	def boxes
		result = Array.new(9) {Array.new}
		sliced_in_threes = @grid.flatten.each_slice(3).to_a
		idx = 0
		while idx < sliced_in_threes.length
			divisor = idx / 9
			if divisor == 0
				result[idx % 3].concat(sliced_in_threes[idx])
			elsif divisor == 1
				result[(idx % 3) + 3].concat(sliced_in_threes[idx])
			else
				result[(idx % 3) + 6].concat(sliced_in_threes[idx])
			end
			idx += 1
		end

		result
	end
end
