require 'set'

class KPF
	def initialize
		@board = Array.new(8) {(1..8).to_a}
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
		pos.all?{|num| num.between?(1, 8)}
	end

	def travail(start, finish)
		family = {}
		seen = Set.new
		q = [start]
		until q.empty?
			current_pos = q.shift
			seen << current_pos
			all_positions(current_pos).each do |adj|
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

		[start] + result.reverse
	end

end

k = KPF.new
p k.travail([0, 0], [2, 2])
