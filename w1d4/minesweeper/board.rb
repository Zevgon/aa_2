require_relative 'tile'

class Board
	def initialize(size = 9)
		@size = size
		@grid = Array.new(size) {Array.new}
		bombify_grid
		render
		numberify_grid_tiles
	end

	def bombify_grid
		@grid.each do |row|
			(0...@grid.length).each do |col|
				random_num = rand(@size)
				if random_num < @size / 4
					new_tile = Tile.new('*')
				else
					new_tile = Tile.new(nil)
				end
				row << new_tile
			end
		end
	end

	def [](pos)
		i, j = pos
		@grid[i][j]
	end

	def []=(pos, val)
		i, j = pos
		@grid[i][j] = val
	end

	def numberify_grid_tiles
		@grid.each.with_index do |row, row_idx|
			row.each.with_index do |col, col_idx|
				next if @grid[row_idx][col_idx].val == '*'
				@grid[row_idx][col_idx].val = bomb_count_surrounding([row_idx, col_idx])
			end
		end
	end

	def bomb_count_surrounding(pos)
		adjacents(pos).count{|tile| tile.val == '*'}
	end

	def adjacents(pos)
		i, j = pos
		result = []
		all_adjes = get_all_adjes(i, j)

		all_adjes.each do |adj|
			result << adj if valid?(adj)
		end

		result.map{|pos| self[pos]}
	end

	def get_all_adjes(i, j)
		[
			[i - 1, j - 1], [i - 1, j], [i - 1, j + 1],
			[i, j - 1], [i, j + 1],
			[i + 1, j - 1], [i + 1, j], [i + 1, j + 1]
		]
	end

	def valid?(pos)
		pos.all?{|ij| ij.between?(0, @size - 1)}
	end

	def render
		puts "  #{(0..8).to_a.join(" ")}"
		@grid.each.with_index do |row, idx|
			puts "#{idx} #{row.join(" ")}"
		end
	end
end

b = Board.new
b.render
