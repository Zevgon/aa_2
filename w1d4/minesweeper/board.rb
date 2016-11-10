require_relative 'tile'
require 'set'

class Board
	def initialize(size, num_bombs)
		@num_bombs = num_bombs - 1
		@size = size
		@grid = Array.new(size) {Array.new}
		bombify_grid
		numberify_grid_tiles
	end

	def bombify_grid
		total = @size ** 2
		bomb_count = @num_bombs
		@grid.each do |row|
			(0...@grid.length).each do |col|
				random_num = rand(total)
				if random_num <= bomb_count
					new_tile = Tile.new('*')
					total -= 1
					bomb_count -= 1
				else
					new_tile = Tile.new
					total -= 1
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
		adjacent_tiles(pos).count{|tile| tile.val == '*'}
	end

	def adjacent_tiles(pos)
		i, j = pos
		result = []
		all_adjes = get_all_adjes(i, j)

		all_adjes.each do |adj|
			result << adj if valid?(adj)
		end

		result.map{|pos| self[pos]}
	end

	def adjacent_positions(pos)
		i, j = pos
		result = []
		all_adjes = get_all_adjes(i, j)

		all_adjes.each do |adj|
			result << adj if valid?(adj)
		end

		result
	end

	def get_all_adjes(i, j)
		[
			[i - 1, j - 1], [i - 1, j], [i - 1, j + 1],
			[i, j - 1], [i, j + 1],
			[i + 1, j - 1], [i + 1, j], [i + 1, j + 1]
		]
	end

	def size
		@grid.length
	end

	def valid?(pos)
		pos.all?{|ij| ij.between?(0, @size - 1)}
	end

	def render
		puts
		puts "   #{(0..@size - 1).to_a.join(" ")}"
		@grid.each.with_index do |row, idx|
			puts "#{idx} #{row.join("")}|"
		end
		puts
	end

	def update(pos, type)
		if type == 'f'
			self[pos].flag!
		else
			self[pos].reveal!
			spread_out(pos)
		end
	end

	def spread_out(pos, seen = nil)
		return unless self[pos].val == 0
		seen ||= Set.new
		seen << pos
		adjes = adjacent_positions(pos)
		adjes.each do |adj|
			self[adj].reveal!
		end

		adjes.each do |adj|
			spread_out(adj, seen) unless seen.include?(adj)
		end
	end

	def lost?
		@grid.each do |row|
			return true if row.any?{|tile| tile.bomb? && tile.revealed}
		end

		false
	end

	def won?
		@grid.each do |row|
			return false if row.any?{|tile| tile.bomb? && !tile.flagged}
		end

		true
	end

	def reveal_all!
		@grid.flatten.each{|tile| tile.reveal!}
	end
end
