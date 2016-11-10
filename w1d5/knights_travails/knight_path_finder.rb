require 'set'

class KPF
	def initialize
		@board = Array.new(8) {Array.new(8, nil)}
	end

	def self.math_grid_indices_to_coding_grid_indices(pos)
		x, y = pos.map{|num| num - 1}
		[7 - y, x]
	end

	def adjacent_positions(pos)
		result = []
		all_positions(pos).each do |pos|
			result << pos if valid?(pos)
		end

		result
	end

	def all_positions(pos)
		i, j = pos
		[
			[i - 2, j + 1],
			[i - 1, j + 2],
			[i + 1, j + 2],
			[i + 2, j + 1],
			[i + 2, j - 1],
			[i + 1, j - 2],
			[i - 1, j - 2],
			[i - 2, j - 1]
		]
	end

	def valid?(pos)
		pos.all?{|num| num.between?(0, 7)}
	end

	def travail(start, finish)
		family = {}
		seen = Set.new
		q = [start]
		until q.empty?
			current_pos = q.shift
			seen << current_pos
			adjacent_positions(current_pos).each do |adj|
				unless seen.include?(adj)
					q << adj
					family[adj] = current_pos
				end
				if adj == finish
					return trace_back(family, adj, start)
				end
			end
		end

		nil
	end

	def trace_back(family, adj, start)
		result = []
		while family.has_key?(adj)
			result << adj
			adj = family[adj]
		end

		make_look_pretty([start] + result.reverse)
	end

	def make_look_pretty(path)
		count = 1
		path.each do |pos|
			i, j = pos
			@board[i][j] = count
			count += 1
		end

		puts ' _ _ _ _ _ _ _ _'
		@board.each do |row|
			row.map!{|square| square ? "|#{square}" : '|_'}
			puts row.join('') + '|'
		end
		puts
	end

end

k = KPF.new
start = ARGV[0].split("").map(&:to_i)
start = KPF.math_grid_indices_to_coding_grid_indices(start)
finish = ARGV[1].split("").map(&:to_i)
finish = KPF.math_grid_indices_to_coding_grid_indices(finish)
start ||= [1, 1]
finish ||= [8, 8]
k.travail(start, finish)
